-- // Variables \\ --

local Module = {}

local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)
local Handler = require(script.Parent.Handler)
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)

local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

local p = game.Players.LocalPlayer
local CommandBar = p.PlayerGui:WaitForChild("VelocityAdmin").CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = CommandBar.AutoComplete

local Info = CommandBar.Info
local Hint = Info.Hint

-- // Functions \\ --

function Module.ExecuteCommand()
    Handler.Data.Arguments = TextBox.Text:split(Settings.CommandBar.AutoComplete.ArgSplit)
    if Handler.Data.CommandInfo.Arguments[#Handler.Data.CommandInfo.Arguments] and Handler.Data.CommandInfo.Arguments[#Handler.Data.CommandInfo.Arguments].NoWordLimit then
        local LastArg = table.concat(Handler.Data.Arguments, Settings.CommandBar.AutoComplete.ArgSplit, #Handler.Data.CommandInfo.Arguments + 1)      
        for i = #Handler.Data.CommandInfo.Arguments + 1, #Handler.Data.Arguments do
            table.remove(Handler.Data.Arguments, #Handler.Data.CommandInfo.Arguments + 1)
        end
        table.insert(Handler.Data.Arguments, LastArg)
    end

    table.remove(Handler.Data.Arguments, 1)
    if Handler.Data.Command and Handler.Data.CommandInfo then
        local Success, Status = Remotes.FireCommand:InvokeServer(Handler.Data)
        if typeof(Success) == "table" then
            for _,Info in pairs(Success) do
                Module.UpdateResponse(Info.Success, Info.Status)
            end
        elseif Status then
            Module.UpdateResponse(Success, Status)     
        end
    end
end

function Module.ExecuteAutoComplete(SelectedField)
    local Args = TextBox.Text:split(Settings.CommandBar.AutoComplete.ArgSplit)
    table.remove(Args, #Args)
    table.insert(Args, SelectedField.Title.Text)

    TextBox.CursorPosition = 1
    RunService.RenderStepped:Wait()
    TextBox.Text = table.concat(Args, Settings.CommandBar.AutoComplete.ArgSplit) .. Settings.CommandBar.AutoComplete.ArgSplit
    TextBox.CursorPosition = #TextBox.Text + 1
end

function Module.UpdateResponse(Success, Status)
    local NewResponse = Info.ListLayout.Response:Clone()
    NewResponse.Label.Text = Status
    NewResponse.Parent = Info
    NewResponse.Size = Settings.CommandBar.Response.DefaultSize + UDim2.new(0, NewResponse.Label.TextBounds.X, 0, 0)

    local MaxDur = Settings.CommandBar.Response.SecondsPerLetter * #Status
    if MaxDur > Settings.CommandBar.Response.MaxDuration then
        MaxDur = Settings.CommandBar.Response.MaxDuration
    end

    if Success then
        local InputModule = require(script.Parent.Input)
        InputModule.ClearText()
        NewResponse.Label.TextColor3 = Settings.CommandBar.Response.SuccessColor
    else
        NewResponse.Label.TextColor3 = Settings.CommandBar.Response.ErrorColor   
    end     

    Debris:AddItem(NewResponse, MaxDur)
end

function Module.UpdateSelectedField(Step)
    for FrameIndex,Frame in pairs(Core.Get(AutoComplete, "Frame")) do
        for _,Field in pairs(Core.Get(Frame, "TextButton")) do
            if Field.IsSelected.Value then

                -- Finds the next possible selected field
                local NewSelectedField
                if Step == 1 then
                    NewSelectedField = Frame:FindFirstChild(Field.Name + Step)
                    if not NewSelectedField then
                        for _, NextFrame in pairs(Core.Get(AutoComplete, "Frame")) do
                            if NextFrame.LayoutOrder == Frame.LayoutOrder + 10 then
                                NewSelectedField = Core.Get(NextFrame, "TextButton")[1]
                                break
                            end
                        end
                    end
                elseif Step == -1 then
                    NewSelectedField = Frame:FindFirstChild(Field.Name + Step)
                    if not NewSelectedField then
                        for _, NextFrame in pairs(Core.Get(AutoComplete, "Frame")) do
                            if NextFrame.LayoutOrder == Frame.LayoutOrder - 10 then
                                NewSelectedField = Core.Get(NextFrame, "TextButton")[#Core.Get(NextFrame, "TextButton")]
                                break
                            end
                        end
                    end
                end

                -- Sets a new selection
                if NewSelectedField then
                    Field.BackgroundColor3 = Settings.CommandBar.AutoComplete.UnselectedColor
                    NewSelectedField.BackgroundColor3 = Settings.CommandBar.AutoComplete.SelectedColor
                    NewSelectedField.IsSelected.Value, Field.IsSelected.Value = true, false
                end
                return
            end
        end
    end
end

function Module.UpdateHint()
    local Args = string.split(TextBox.Text, Settings.CommandBar.AutoComplete.ArgSplit)  
    for Type,Commands in pairs(Handler.Commands) do
        for Command, Info in pairs(Commands) do
            if Command:lower() == Args[1]:lower() then
                -- Gets the argument info
                local ArgumentInfo
                if Info.Arguments[#Info.Arguments] then
                    if Info.Arguments[#Info.Arguments].NoWordLimit and #Args > #Info.Arguments then
                        ArgumentInfo = Info.Arguments[#Info.Arguments]
                    else
                        ArgumentInfo = Info.Arguments[#Args-1]
                    end
                end

                -- Creates the hint
                if ArgumentInfo then
                    Hint.Title.Text = ArgumentInfo.Title
                    Hint.Description.Text = ArgumentInfo.Description
                    Hint.Visible = true
                    Hint.Title.Size = UDim2.new(0, Hint.Title.TextBounds.X + Settings.CommandBar.Hint.Spacing, 1, 0)
                    Hint.Description.Size = UDim2.new(0, Hint.Description.TextBounds.X + Settings.CommandBar.Hint.Spacing, 1, 0)
                    Hint.Size = UDim2.new(0, Hint.Title.Size.X.Offset + Hint.Description.Size.X.Offset, 0, Settings.CommandBar.Hint.DefaultSize.Y.Offset)                
                    return
                end
            end
        end
    end
    Hint.Visible = false
end

function Module.CreateFields(PossibleFields)
    local HeadingNum = 0

    -- Creates the auto completion section
    for Heading, Cmds in pairs(PossibleFields) do
        HeadingNum = HeadingNum + 1

        if #Cmds > 0 then

            -- Creates the Heading
            local NewHeading = AutoComplete.ListLayout.Heading:Clone() do
                NewHeading.LayoutOrder = HeadingNum * 10
                NewHeading.Name = Heading .. "-Heading"
                NewHeading.TextLabel.Text = Heading:gsub("_", ": ")
                NewHeading.Parent = AutoComplete
            end

            -- Creates the Field Frame
            local NewFieldFrame = AutoComplete.ListLayout.FieldFrame:Clone() do
                NewFieldFrame.LayoutOrder = HeadingNum * 10 + 1
                NewFieldFrame.Name = Heading .. "-Frame"
                NewFieldFrame.Parent = AutoComplete
            end

            -- Event for heading clicked
            NewHeading.MouseButton1Click:Connect(function()
                NewFieldFrame.Visible = not NewFieldFrame.Visible
            end)

            -- Creates the fields
            local FieldNum = 0
            for Cmd, Info in pairs(Cmds) do

                -- Creates the field
                FieldNum = FieldNum + 1
                local NewField = NewFieldFrame.ListLayout.Field:Clone() do
                    NewField.LayoutOrder = FieldNum                 
                    NewField.Title.Text = Info.Title
                    NewField.Description.Text = Info.Description
                    NewField.Name = Cmd
                end
                
                -- Sets the selection
                if HeadingNum == 1 and FieldNum == 1 then
                    NewField.IsSelected.Value = true
                    NewField.BackgroundColor3 = Settings.CommandBar.AutoComplete.SelectedColor
                end

                -- Other properties
                NewField.Parent = NewFieldFrame
                NewField.Title.Size = UDim2.new(0, NewField.Title.TextBounds.X, 1, 0)
                NewField.Description.Size = UDim2.new(1, -NewField.Title.TextBounds.X - 20 - Settings.CommandBar.AutoComplete.TitleToDescriptionSpacing, 1, 0)

                -- Adjusts if the sizing is too small
                local yMultiplier = math.floor(NewField.Description.TextBounds.X / NewField.Description.AbsoluteSize.X) + 1
                if yMultiplier > 1 then
                    NewField.Description.TextWrapped = true
                    NewField.Size = UDim2.new(1, 0, 0, yMultiplier * 20)
                end

                -- Click Event
                NewField.MouseButton1Click:Connect(function()
                    Module.ExecuteAutoComplete(NewField)
                end)

            end

            NewFieldFrame.Size = UDim2.new(1, 0, 0, NewFieldFrame.ListLayout.AbsoluteContentSize.Y)
        end
    end
end

function Module.CheckDifference(Heading, Title, Description, LastArg, Table, GetAll)
    -- Check if already in table
    local Found
    for _,Info in pairs(Table) do
        if Info.Title == Title then
            Found = true
            break
        end
    end

    -- Check differences in chars
    if LastArg:lower():sub(1, #LastArg) == Title:lower():sub(1, #LastArg) and not Found then
        GetAll = true
    end

    -- Inserts in table
    if GetAll then
        table.insert(Table, {
            ["Title"] = Title,
            ["Description"] = Description
        })  
    end   
end

function Module.GetFields(Text)
    local PossibleFields = {}
    local Args = Text:split(Settings.CommandBar.AutoComplete.ArgSplit)
    Text = Text:lower()

    if #Args == 1 then
        local GetAll = string.sub(Text, #Text) == "" or string.sub(Text, #Text) == " " 
        for Heading, Cmds in pairs(Handler.Commands) do
            PossibleFields[Heading] = {}
            for Title, Info in pairs(Cmds) do
                Module.CheckDifference(Heading, Title, Info.Description, Args[#Args], PossibleFields[Heading], GetAll)
            end
        end
    elseif #Args > 1 then

        for Heading, Cmds in pairs(Handler.Commands) do
            local Command = Cmds[Args[1]:lower()]
            if Command then
                PossibleFields[Heading] = {}

                Handler.Data.Command = Args[1]:lower()
                Handler.Data.CommandInfo = Command
                Handler.Data.Arguments = {}
    
                local Argument = Command.Arguments[#Args-1]
                if Argument then
                    Handler.Data.Argument = Argument
    
                    local Choices           
                    if typeof(Argument.Choices) == "function" then
                        Choices = Argument.Choices(p)
                    elseif typeof(Argument.Choices) == "table" then
                        Choices = Argument.Choices
                    end
    
                    local GetAll = Text:sub(#Text) == "" or Text:sub(#Text) == " "
                    for Sect1, Sect2 in pairs(Choices or {}) do

                        local Title, Description
                        if typeof(Sect1) == "number" then
                            Title = Sect2
                            Description = Command.Description
                        elseif typeof(Sect1) == "string" then
                            Title = Sect1
                            Description = Sect2
                        end

                        Module.CheckDifference(Heading, Title, Description, Args[#Args], PossibleFields[Heading], GetAll)
                    end
                end
            end  
        end       
    end

    return PossibleFields
end

function Module.TextChanged()
    -- Set the size of the command bar
    CommandBar.Size = Settings.CommandBar.DefaultSize + UDim2.new(0, TextBox.TextBounds.X, 0, 0)

    -- Delete existing auto complete fields
    for _,Field in pairs(AutoComplete:GetChildren()) do
        if Field:IsA("Frame") or Field:IsA("TextButton") then
            Field:Destroy()
        end
    end

    -- Create new auto complete fields
    local PossibleFields = Module.GetFields(TextBox.Text)
    if PossibleFields then
        Module.CreateFields(PossibleFields)
        Module.UpdateHint()
    end
    
    -- Set size of auto complete
    AutoComplete.Size = UDim2.new(0, Settings.CommandBar.AutoComplete.FieldSizeX, 0, AutoComplete.Parent.Parent.AbsoluteSize.Y/2)
    AutoComplete.CanvasSize = UDim2.new(0, 0, 0, AutoComplete.ListLayout.AbsoluteContentSize.Y)
end

return Module
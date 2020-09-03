-- // Variables \\ --

local Module = {}

local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local Core = require(game.ReplicatedStorage.Modules.Core)
local Handler = require(script.Parent.Handler)
local Settings = require(script.Parent.Settings)

local Remotes = game.ReplicatedStorage.Remotes
local Commands = require(game.ReplicatedStorage.Velocity).Commands

local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = CommandBar.AutoComplete

local Info = CommandBar.Info
local Hint = Info.Hint

-- // Functions \\ --

function Module.ExecuteCommand()
    Handler.Data.Arguments = TextBox.Text:split(Settings.CommandBar.AutoComplete.ArgSplit)
    table.remove(Handler.Data.Arguments, 1)

    if Handler.Data.Command and Handler.Data.CommandInfo then
        local Success, Status = Remotes.FireCommand:InvokeServer(Handler.Data)
        if Status then
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
    for _,OldSelectedField in pairs(Core.Get(AutoComplete, "TextButton")) do
        if OldSelectedField.IsSelected.Value then
            local NewSelectedField = AutoComplete:FindFirstChild(OldSelectedField.Name + Step)
            if NewSelectedField then
                OldSelectedField.BackgroundColor3 = Settings.CommandBar.AutoComplete.UnselectedColor
                NewSelectedField.BackgroundColor3 = Settings.CommandBar.AutoComplete.SelectedColor
                NewSelectedField.IsSelected.Value, OldSelectedField.IsSelected.Value = true, false
            end
            return
        end
    end
end

function Module.UpdateHint()
    local Args = string.split(TextBox.Text, Settings.CommandBar.AutoComplete.ArgSplit)
    for Name, Info in pairs(Commands) do
        if Name:lower() == Args[1]:lower() then
            local ArgumentInfo = Info.Arguments[#Args-1]
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
    Hint.Visible = false
end

function Module.CreateFields(PossibleFields)
    local BiggestSize = 0
    for i, Field in pairs(PossibleFields) do

        -- Create new field
        local NewField = AutoComplete.ListLayout.Template:Clone() do
            NewField.Title.Text = Field.Title
            NewField.Description.Text = Field.Description
            NewField.Name, NewField.LayoutOrder = i, i
        end
        
        -- Set selection
        if i == 1 then
            NewField.IsSelected.Value = true
            NewField.BackgroundColor3 = Settings.CommandBar.AutoComplete.SelectedColor
        end

        -- Set sizes
        NewField.Parent = AutoComplete
        NewField.Title.Size = UDim2.new(0, NewField.Title.TextBounds.X, 1, 0)

        local X = NewField.Description.TextBounds.X
        local FinalY = Core.Round(X/Settings.CommandBar.AutoComplete.MaxDescriptionSize) + 1            
        if FinalY > 1 then
            NewField.Description.TextWrapped = true
        end
        NewField.Description.Size = UDim2.new(0, X/FinalY, 1, 0)
        NewField.Size = UDim2.new(0, Settings.CommandBar.AutoComplete.MaxDescriptionSize, FinalY, 0)

        local GoalX = NewField.Description.Size.X.Offset + NewField.Title.Size.X.Offset + Settings.CommandBar.AutoComplete.FieldSpacing
        if GoalX > BiggestSize then
            BiggestSize = GoalX
        end

        NewField.MouseButton1Click:Connect(function()
            Module.ExecuteAutoComplete(NewField)
        end)
    end

    for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
        Field.Size = UDim2.new(0, BiggestSize, Field.Size.Y.Scale, 0)
    end
end

function Module.CheckDifference(Title, Description, LastArg, Table, GetAll)
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
    local Args = Text:split(Settings.CommandBar.AutoComplete.ArgSplit)
    local PossibleFields = {}
    Text = Text:lower()

    if #Args == 1 then
        local GetAll = string.sub(Text, #Text) == "" or string.sub(Text, #Text) == " " 
        for Title, Info in pairs(Commands) do
            Module.CheckDifference(Title, Info.Description, Args[#Args], PossibleFields, GetAll)
        end
    elseif #Args > 1 then
        local Command = Commands[Args[1]:lower()]
        if Command then
            Handler.Data.Command = Args[1]:lower()
            Handler.Data.CommandInfo = Command
            Handler.Data.Arguments = {}

            local Argument = Command.Arguments[#Args-1]
            if Argument then
                Handler.Data.Argument = Argument

                local Choices           
                if typeof(Argument.Choices) == "function" then
                    Choices = Argument.Choices()
                elseif typeof(Argument.Choices) == "table" then
                    Choices = Argument.Choices
                end

                local GetAll = Text:sub(#Text) == "" or Text:sub(#Text) == " "
                for _,Title in pairs(Choices or {}) do
                    Module.CheckDifference(Title, "", Args[#Args], PossibleFields, GetAll)
                end
            end
        end  
    end

    return PossibleFields
end

function Module.TextChanged()
    CommandBar.Size = Settings.CommandBar.DefaultSize + UDim2.new(0, TextBox.TextBounds.X, 0, 0)

    for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
        Field:Destroy()
    end

    local PossibleFields = Module.GetFields(TextBox.Text)
    if PossibleFields then
        Module.CreateFields(PossibleFields)
        Module.UpdateHint()
    end
    
    AutoComplete.Size = Settings.CommandBar.AutoComplete.FieldSize + UDim2.new(0, AutoComplete.ListLayout.AbsoluteContentSize.X, 0, 0)
end

return Module
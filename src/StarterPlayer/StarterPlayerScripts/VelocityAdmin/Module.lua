-- // Variables \\ --

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Settings = require(script.Parent.Settings)
local Core = require(script.Parent.Core)
local p = game.Players.LocalPlayer

local CommandBar = p.PlayerGui:WaitForChild("VelocityAdmin").CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = CommandBar.AutoComplete

local Module = {
    InputFunctions = {
        Settings.CommandBar.AutoComplete.UpKey;
        Settings.CommandBar.AutoComplete.DownKey;
        Settings.CommandBar.AutoComplete.UseKey1;
        Settings.CommandBar.AutoComplete.UseKey2;
        Settings.CommandBar.OpenKey;
    },
    Cons = {},
}


-- // Functions \\ --

    -- Helper

function Module.DisconnectCon(Con)
    if Module.Cons[Con] then
        Module.Cons[Con]:Disconnect()
    end
end

    -- Auto Complete

function Module.RunAutoComplete(SelectedField)
    local Args = string.split(TextBox.Text, Settings.CommandBar.AutoComplete.ArgSplit)
    table.remove(Args, #Args)
    table.insert(Args, SelectedField.Title.Text)

    TextBox.CursorPosition = 1
    RunService.RenderStepped:Wait()
    TextBox.Text = table.concat(Args, Settings.CommandBar.AutoComplete.ArgSplit) .. " "
    TextBox.CursorPosition = #TextBox.Text + 1
end

function Module.HandleAutoComplete(Step)
    local OldSelectedField
    for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
        if Field.IsSelected.Value then
            OldSelectedField = Field
            break
        end
    end

    if OldSelectedField then
        local NewSelectedField = AutoComplete:FindFirstChild(OldSelectedField.Name + Step)
        if NewSelectedField then
            OldSelectedField.BackgroundColor3 = Settings.CommandBar.AutoComplete.UnselectedColor
            OldSelectedField.IsSelected.Value = false
        
            NewSelectedField.BackgroundColor3 = Settings.CommandBar.AutoComplete.SelectedColor
            NewSelectedField.IsSelected.Value = true
        end
    end
end

function Module.GetFields(Text)
    local Args = string.split(Text, Settings.CommandBar.AutoComplete.ArgSplit)
    local LastArg = Args[#Args]
    local PossibleFields = {}

    for Title, Description in pairs(Settings.CommandBar.AutoComplete.Words) do
        for CharNum = #LastArg, 1, -1 do
            local Found
            for _,Info in pairs(PossibleFields) do
                if Info.Title == Title then
                    Found = true
                    break
                end
            end

            if string.sub(string.lower(LastArg), 1, CharNum) == string.sub(string.lower(Title), 1, CharNum) and not Found then
                table.insert(PossibleFields, {
                    ["Title"] = Title,
                    ["Description"] = Description
                })
            end
            break
        end
    end

    return PossibleFields
end

function Module.CheckAutoComplete()
    CommandBar.Size = Settings.CommandBar.DefaultSize + UDim2.new(0, TextBox.TextBounds.X, 0, 0)

    for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
        Field:Destroy()
    end

    local PossibleFields = Module.GetFields(TextBox.Text)
    local BiggestSize = 0
    if PossibleFields then
        for i, Field in pairs(PossibleFields) do
            local NewField = AutoComplete.ListLayout.Template:Clone()
            NewField.Title.Text = Field.Title
            NewField.Description.Text = Field.Description
            NewField.Name, NewField.LayoutOrder = i, i

            if i == 1 then
                NewField.IsSelected.Value = true
                NewField.BackgroundColor3 = Settings.CommandBar.AutoComplete.SelectedColor
            end

            NewField.Parent = AutoComplete
            NewField.Title.Size = UDim2.new(0, NewField.Title.TextBounds.X, 1, 0)

            local X = NewField.Description.TextBounds.X
            local FinalY = Core.Round(X/Settings.CommandBar.AutoComplete.MaxDescriptionSize) + 1            
            if FinalY > 1 then
                NewField.Description.Size = UDim2.new(0, X/FinalY, 1, 0)
                NewField.Description.TextWrapped = true
                NewField.Size = UDim2.new(0, Settings.CommandBar.AutoComplete.MaxDescriptionSize, FinalY, 0)
            else
                NewField.Description.Size = UDim2.new(0, X, 1, 0)
                NewField.Size = UDim2.new(0, Settings.CommandBar.AutoComplete.MaxDescriptionSize, 1, 0)
            end

            local GoalX = NewField.Description.Size.X.Offset + NewField.Title.Size.X.Offset + Settings.CommandBar.AutoComplete.FieldSpacing
            if GoalX > BiggestSize then
                BiggestSize = GoalX
            end

            NewField.MouseButton1Click:Connect(function()
                Module.RunAutoComplete(NewField)
            end)
        end

        for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
            Field.Size = UDim2.new(0, BiggestSize, Field.Size.Y.Scale, 0)
        end
    end
    
    AutoComplete.Size = Settings.CommandBar.AutoComplete.FieldSize + UDim2.new(0, AutoComplete.ListLayout.AbsoluteContentSize.X, 0, 0)
end

    -- Input

function Module.Returned()
    local SelectedField
    for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
        if Field.IsSelected.Value then
            SelectedField = Field
        end
    end

    if SelectedField then
        Module.RunAutoComplete(SelectedField)
    else
        Module.CloseUI()
    end   
end

function Module.CloseUI()
    CommandBar.Visible = false
    TextBox:ReleaseFocus()
    Module.DisconnectCon("CloseUI")
end

Module.InputFunctions[Settings.CommandBar.AutoComplete.UpKey] = function()
    Module.HandleAutoComplete(-1)
end

Module.InputFunctions[Settings.CommandBar.AutoComplete.DownKey] = function()
    Module.HandleAutoComplete(1)
end

Module.InputFunctions[Settings.CommandBar.AutoComplete.UseKey1] = function()
    Module.Returned()
end

Module.InputFunctions[Settings.CommandBar.AutoComplete.UseKey2] = function()
    Module.Returned()
end

Module.InputFunctions[Settings.CommandBar.OpenKey] = function()
    CommandBar.Visible = not CommandBar.Visible
    Module.DisconnectCon("CloseUI")
    if CommandBar.Visible then
        TextBox:CaptureFocus()
        RunService.RenderStepped:Wait()
        TextBox.Text = ""
        Module.Cons.CloseUI = TextBox.InputBegan:Connect(Module.RunUI)
    end
end

Module.InputFunctions[Settings.CommandBar.ExitKey] = function()
    Module.CloseUI()
end

function Module.RunUI(Input)
    local PossibleFunction = Module.InputFunctions[Input.KeyCode]
    if PossibleFunction then
        PossibleFunction()
    end
end

    -- Main

function Module.Init()
    CommandBar.Position = Settings.CommandBar.DefaultPos
    CommandBar.Visible = false

    UserInputService.InputBegan:Connect(Module.RunUI)
    TextBox:GetPropertyChangedSignal("Text"):Connect(Module.CheckAutoComplete)
end

return Module
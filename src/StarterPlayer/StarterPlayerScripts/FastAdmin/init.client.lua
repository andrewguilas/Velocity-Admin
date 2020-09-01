local Core = require(game.ReplicatedStorage.Modules.Core)
local Settings = require(script.Settings)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local p = game.Players.LocalPlayer

local UI = p.PlayerGui:WaitForChild("FastAdmin")
local CommandBar = UI.CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = UI.AutoComplete

local Cons = {
    CloseUI = nil,
}

-- // Defaults \\ --

CommandBar.Visible, AutoComplete.Visible = true, true
CommandBar.Position, AutoComplete.Position = Settings.CommandBar.Startup.HiddenPos, Settings.CommandBar.Startup.HiddenPos

-- // Functions \\ --

function DisconnectCon(Con)
    if Cons[Con] then
        Cons[Con]:Disconnect()
    end
end

function GetFields(Text)
    local Args = string.split(Text, Settings.CommandBar.AutoComplete.ArgSplit)
    local LastArg = Args[#Args]

    local PossibleFields = {}

    for Title,Description in pairs(Settings.CommandBar.AutoComplete.Words) do
        for CharNum = #LastArg, 1, -1 do
            local Found = false
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

function RunAutoComplete()

    for _,Field in pairs(Core.Get(AutoComplete, "Frame")) do
        Field:Destroy()
    end

    local PossibleFields = GetFields(TextBox.Text)
    local BiggestSize = 0
    if PossibleFields then

        for i,Field in pairs(PossibleFields) do
            local NewField = AutoComplete.ListLayout.Template:Clone()
            NewField.Title.Text = Field.Title
            NewField.Description.Text = Field.Description
            NewField.Name, NewField.LayoutOrder = i, i
            NewField.Parent = AutoComplete
            NewField.Title.Size = UDim2.new(0, NewField.Title.TextBounds.X, 1, 0)

            local X = NewField.Description.TextBounds.X
            local FinalY = Core.Round(X/Settings.CommandBar.Text.MaxSize) + 1            
            if FinalY > 1 then
                NewField.Description.Size = UDim2.new(0, X/FinalY, 1, 0)
                NewField.Description.TextWrapped = true
                NewField.Size = UDim2.new(0, Settings.CommandBar.Text.MaxSize, FinalY, 0)
            else
                NewField.Description.Size = UDim2.new(0, X, 1, 0)
                NewField.Size = UDim2.new(0, Settings.CommandBar.Text.MaxSize, 1, 0)
            end

            local GoalX = NewField.Description.Size.X.Offset + NewField.Title.Size.X.Offset + Settings.CommandBar.AutoComplete.FieldSpacing
            if GoalX > BiggestSize then
                BiggestSize = GoalX
            end
        end

        for _,Field in pairs(Core.Get(AutoComplete, "Frame")) do
            Field.Size = UDim2.new(0, BiggestSize, Field.Size.Y.Scale, 0)
        end

        local Goal = Settings.CommandBar.AutoComplete.FieldSize + UDim2.new(0, AutoComplete.ListLayout.AbsoluteContentSize.X, 0, 0)
        AutoComplete:TweenSize(Goal, Settings.CommandBar.AutoComplete.TweenInfo.Direction, Settings.CommandBar.AutoComplete.TweenInfo.Style, Settings.CommandBar.AutoComplete.TweenInfo.Duration, Settings.CommandBar.AutoComplete.TweenInfo.Overrides)

        AutoComplete.Shown.Value = false
        AutoComplete:TweenPosition(Settings.CommandBar.AutoComplete.ShowPos, Settings.CommandBar.Startup.TweenInfo.Direction, Settings.CommandBar.Startup.TweenInfo.Style, Settings.CommandBar.Startup.TweenInfo.Duration, Settings.CommandBar.Startup.TweenInfo.Overrides)
    else
        AutoComplete.Shown.Value = false
        AutoComplete:TweenPosition(Settings.CommandBar.Startup.HiddenPos, Settings.CommandBar.Startup.TweenInfo.Direction, Settings.CommandBar.Startup.TweenInfo.Style, Settings.CommandBar.Startup.TweenInfo.Duration, Settings.CommandBar.Startup.TweenInfo.Overrides)      
    end
end

function ExpandUI()
    local Goal = Settings.CommandBar.Text.Size + UDim2.new(0, TextBox.TextBounds.X, 0, 0)
    CommandBar:TweenSize(Goal, Settings.CommandBar.Text.TweenInfo.Direction, Settings.CommandBar.Text.TweenInfo.Style, Settings.CommandBar.Text.TweenInfo.Duration, Settings.CommandBar.Text.TweenInfo.Overrides)
end

function OpenUI(Input, GameProcessed)
    if Input.KeyCode == Settings.CommandBar.Startup.Key then
        if CommandBar.Shown.Value then
            CommandBar.Shown.Value = false
            CommandBar:TweenPosition(Settings.CommandBar.Startup.HiddenPos, Settings.CommandBar.Startup.TweenInfo.Direction, Settings.CommandBar.Startup.TweenInfo.Style, Settings.CommandBar.Startup.TweenInfo.Duration, Settings.CommandBar.Startup.TweenInfo.Overrides)

            AutoComplete.Shown.Value = false
            AutoComplete:TweenPosition(Settings.CommandBar.Startup.HiddenPos, Settings.CommandBar.Startup.TweenInfo.Direction, Settings.CommandBar.Startup.TweenInfo.Style, Settings.CommandBar.Startup.TweenInfo.Duration, Settings.CommandBar.Startup.TweenInfo.Overrides)
            
            TextBox:ReleaseFocus()
            DisconnectCon("CloseUI")
        else
            CommandBar.Shown.Value = true
            CommandBar:TweenPosition(Settings.CommandBar.Startup.ShownPos, Settings.CommandBar.Startup.TweenInfo.Direction, Settings.CommandBar.Startup.TweenInfo.Style, Settings.CommandBar.Startup.TweenInfo.Duration, Settings.CommandBar.Startup.TweenInfo.Overrides)

            AutoComplete.Shown.Value = false
            CommandBar:TweenPosition(Settings.CommandBar.Startup.ShownPos, Settings.CommandBar.Startup.TweenInfo.Direction, Settings.CommandBar.Startup.TweenInfo.Style, Settings.CommandBar.Startup.TweenInfo.Duration, Settings.CommandBar.Startup.TweenInfo.Overrides)
            
            TextBox:CaptureFocus()
            wait()
            TextBox.Text = ""

            DisconnectCon("CloseUI")
            Cons.CloseUI = TextBox.InputBegan:Connect(OpenUI)
        end  
    elseif Input.KeyCode == Settings.CommandBar.AutoComplete.Key and AutoComplete:FindFirstChild("1") then
        local Args = string.split(TextBox.Text, Settings.CommandBar.AutoComplete.ArgSplit)
        table.remove(Args, #Args)
        table.insert(Args, AutoComplete[1].Title.Text)

        TextBox.CursorPosition = 1
        RunService.RenderStepped:Wait()
        TextBox.Text = table.concat(Args, Settings.CommandBar.AutoComplete.ArgSplit) .. " "
        TextBox.CursorPosition = #TextBox.Text + 1
    end   
end

-- // Events \\ --

TextBox:GetPropertyChangedSignal("TextBounds"):Connect(ExpandUI)
TextBox:GetPropertyChangedSignal("Text"):Connect(RunAutoComplete)
UserInputService.InputBegan:Connect(OpenUI)
-- // Settings \\ --

local STARTUP_KEYBIND = Enum.KeyCode.BackSlash

    -- Animation
local ANIM_HIDDEN_POS = UDim2.new(0.3, 10, -0.2, 10)
local ANIM_SHOWN_POS = UDim2.new(0.3, 10, 0, 10)
local SHOW_EASE_DIRECTION = Enum.EasingDirection.In
local SHOW_EASE_STYLE = Enum.EasingStyle.Linear
local SHOW_DUR = 0.2
local SHOW_OVERRIDES = true

    -- Size
local DEFAULT_SIZE = UDim2.new(0, 40, 0, 20)
local TEXT_EASE_DIRECTION = Enum.EasingDirection.In
local TEXT_EASE_STYLE = Enum.EasingStyle.Linear
local TEXT_DUR = 0.2
local TEXT_OVERRIDES = true

    -- AutoComplete
local AUTO_COMPLETE_SHOWN_POS = UDim2.new(0.3, 10, 0, 32)   
local FIELD_TITLE_SIZE = UDim2.new(0, 15, 1, 0)
local FIELD_DESCRIPTION_SIZE = UDim2.new(0, 15, 1, 0)
local FIELD_SIZE = UDim2.new(20, 0, 0, 20)
local ARG_SPLIT = " "
local WORDS = {
    ["Jet"] = "was good, then bad, then tried to be good, but was actually bad the ENTIRE TIME, and then he became bad  because he was brain washed, but then he realized that he was brain washed so he became good, but then he was controlled again from the previous brain washing experience and became bad, but when he died, he becam,e good.",
    ["Potato"] = "Makes french fries!",
    ["HotDog"] = "Good with ketchup and mayo",
    ["HotMan"] = "Old Fire Nation Slang",
    ["Celery"] = "A VEG-ET-A-BLE",
    ["Cool"] = "Someone who is cool, or the temperature",
    ["coraa"] = "hated instantly by the fandom for no reason lol",
    ["ro ro ro ro hoe"] = "you're not professional until you use it",
    ["pizza"] = "some italian food idk never heard of it",
    ["crazy man"] = "some aero guy"
}

-- // Variables \\ --

local Core = require(game.ReplicatedStorage.Modules.Core)
local UserInputService = game:GetService("UserInputService")
local p = game.Players.LocalPlayer

    -- UI
local UI = p.PlayerGui:WaitForChild("FastAdmin")
local CommandBar = UI.CommandBar
local TextBox = CommandBar.TextBox

local AutoComplete = UI.AutoComplete

    -- Other
local CloseUiCon

-- // Defaults \\ --

CommandBar.Visible = true
CommandBar.Position = ANIM_HIDDEN_POS
AutoComplete.Visible = true
AutoComplete.Position = ANIM_HIDDEN_POS

-- // Functions \\ --

    -- Helper
function DisconnectCon(Con)
    if Con then
        Con:Disconnect()
    end
end

    -- Auto Complete
function GetFields(Text)
    local Args = string.split(Text, ARG_SPLIT)
    local LastArg = Args[#Args]

    local PossibleFields = {}

    for Title,Description in pairs(WORDS) do
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

    local Text = TextBox.Text
    for _,Field in pairs(Core.Get(AutoComplete, "Frame")) do
        Field:Destroy()
    end

    local PossibleFields = GetFields(Text)
    local BiggestSize = 0
    if PossibleFields then

        for i,Field in pairs(PossibleFields) do
            local NewField = AutoComplete.ListLayout.Template:Clone()
            NewField.Title.Text = Field.Title
            NewField.Description.Text = Field.Description
            NewField.Name, NewField.LayoutOrder = i, i
            NewField.Parent = AutoComplete
            NewField.Title.Size = FIELD_TITLE_SIZE + UDim2.new(0, NewField.Title.TextBounds.X, 0, 0)
            NewField.Description.Size = UDim2.new(0, NewField.Description.TextBounds.X, 1, 0)

            local GoalX = NewField.Description.Size.X.Offset + NewField.Title.Size.X.Offset + 80
            if GoalX > BiggestSize then
                BiggestSize = GoalX
            end

        end

        for _,Field in pairs(Core.Get(AutoComplete, "Frame")) do
            Field.Size = UDim2.new(0,BiggestSize, 1, 0)
        end

        local Goal = FIELD_SIZE + UDim2.new(0, AutoComplete.ListLayout.AbsoluteContentSize.X, 0, 0)
        AutoComplete:TweenSize(Goal, TEXT_EASE_DIRECTION, TEXT_EASE_STYLE, TEXT_DUR, TEXT_OVERRIDES)

        AutoComplete.Shown.Value = false
        AutoComplete:TweenPosition(AUTO_COMPLETE_SHOWN_POS, SHOW_EASE_DIRECTION, SHOW_EASE_STYLE, SHOW_DUR, SHOW_OVERRIDES)
    else
        AutoComplete.Shown.Value = false
        AutoComplete:TweenPosition(ANIM_SHOWN_POS, SHOW_EASE_DIRECTION, SHOW_EASE_STYLE, SHOW_DUR, SHOW_OVERRIDES)       
    end
end

    -- Main

function ExpandUI()
    local Goal = DEFAULT_SIZE + UDim2.new(0, TextBox.TextBounds.X, 0, 0)
    CommandBar:TweenSize(Goal, TEXT_EASE_DIRECTION, TEXT_EASE_STYLE, TEXT_DUR, TEXT_OVERRIDES)
end

function OpenUI(Input, GameProcessed)
    if Input.KeyCode == STARTUP_KEYBIND then
        if CommandBar.Shown.Value then
            CommandBar.Shown.Value = false
            CommandBar:TweenPosition(ANIM_HIDDEN_POS, SHOW_EASE_DIRECTION, SHOW_EASE_STYLE, SHOW_DUR, SHOW_OVERRIDES)

            AutoComplete.Shown.Value = false
            AutoComplete:TweenPosition(ANIM_HIDDEN_POS, SHOW_EASE_DIRECTION, SHOW_EASE_STYLE, SHOW_DUR, SHOW_OVERRIDES)
            
            TextBox:ReleaseFocus()
            DisconnectCon(CloseUiCon)
        else
            CommandBar.Shown.Value = true
            CommandBar:TweenPosition(ANIM_SHOWN_POS, SHOW_EASE_DIRECTION, SHOW_EASE_STYLE, SHOW_DUR, SHOW_OVERRIDES)

            AutoComplete.Shown.Value = false
            AutoComplete:TweenPosition(ANIM_SHOWN_POS, SHOW_EASE_DIRECTION, SHOW_EASE_STYLE, SHOW_DUR, SHOW_OVERRIDES)
            
            TextBox:CaptureFocus()
            wait()
            TextBox.Text = ""

            DisconnectCon(CloseUiCon)
            CloseUiCon = TextBox.InputBegan:Connect(OpenUI)
        end        
    end   
end

-- // Events \\ --

TextBox:GetPropertyChangedSignal("TextBounds"):Connect(ExpandUI)
TextBox:GetPropertyChangedSignal("Text"):Connect(RunAutoComplete)
UserInputService.InputBegan:Connect(OpenUI)
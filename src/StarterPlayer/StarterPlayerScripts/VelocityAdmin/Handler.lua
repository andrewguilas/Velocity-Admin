-- // Variables \\ --

local Module = {
    Cons = {},
}

-- // Functions \\ --

function Module.DisconnectCon(Con)
    if Module.Cons[Con] then
        Module.Cons[Con]:Disconnect()
    end
end

function Module.Init()
    local UserInputService = game:GetService("UserInputService")
    local InputModule = require(script.Parent.Input)
    local AutoCompleteModule = require(script.Parent.AutoComplete)
    local Settings = require(script.Parent.Settings)
    local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar

    CommandBar.Position = Settings.CommandBar.DefaultPos
    CommandBar.Visible = false

    UserInputService.InputBegan:Connect(InputModule.RunUI)
    CommandBar.TextBox:GetPropertyChangedSignal("Text"):Connect(AutoCompleteModule.CheckAutoComplete)
end

return Module
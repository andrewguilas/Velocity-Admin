-- // Variables \\ --

local Module = {
    Commands = {},
    Data = {
        Command = nil,
        CommandInfo = {},
        Argument = nil,
        Arguments = {}
    },
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
    local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
    local Commands = game.ReplicatedStorage.VelocityAdmin.Modules.Commands

    for _,Heading in pairs(Commands:GetChildren()) do
        Module.Commands[Heading.Name] = {}
        for __,Cmd in pairs(Heading:GetChildren()) do
            Module.Commands[Heading.Name][Cmd.Name] = require(Cmd)
        end
    end

    local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar

    CommandBar.Position = Settings.CommandBar.DefaultPos
    CommandBar.Visible = false

    UserInputService.InputBegan:Connect(InputModule.RunUI)
    CommandBar.TextBox:GetPropertyChangedSignal("Text"):Connect(AutoCompleteModule.TextChanged)
end

return Module
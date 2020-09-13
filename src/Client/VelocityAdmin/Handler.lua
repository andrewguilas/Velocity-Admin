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
    -- Variables
    local UserInputService = game:GetService("UserInputService")
    local InputModule = require(script.Parent.Input)
    local AutoCompleteModule = require(script.Parent.AutoComplete)
    local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
    local Commands = game.ReplicatedStorage.VelocityAdmin.Modules.Commands
    local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar

    -- Requires all commands and places them into a dictionary
    for _,Heading in pairs(Commands:GetChildren()) do
        Module.Commands[Heading.Name] = {}
        for __,Cmd in pairs(Heading:GetChildren()) do
            Module.Commands[Heading.Name][Cmd.Name] = require(Cmd)
        end
    end

    -- Sets default properties of command bar
    CommandBar.Position = Settings.CommandBar.DefaultPos
    CommandBar.Visible = false

    -- Fires functions when player starts input or types
    UserInputService.InputBegan:Connect(InputModule.RunInput)
    CommandBar.TextBox:GetPropertyChangedSignal("Text"):Connect(AutoCompleteModule.TextChanged)
end

return Module
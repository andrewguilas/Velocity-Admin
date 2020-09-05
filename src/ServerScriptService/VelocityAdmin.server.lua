local Remotes = game.ReplicatedStorage.Remotes
local Velocity = require(game.ReplicatedStorage.Modules.Velocity)
local Commands = Velocity.Commands

game.Players.PlayerAdded:Connect(function(p)
    Velocity.TempData[p.Name] = {}
end)

game.Players.PlayerRemoving:Connect(function(p)
    Velocity.TempData[p.Name] = nil
end)

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    local SelectedCommand = Commands[Data.Command]
    if SelectedCommand then
        return SelectedCommand.Run(p, table.unpack(Data.Arguments))
    end
end
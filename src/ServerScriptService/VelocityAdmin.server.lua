local Remotes = game.ReplicatedStorage.Remotes
local Velocity = require(game.ReplicatedStorage.Velocity)
local Commands = Velocity.Commands

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    local SelectedCommand = Commands[Data.Command]
    if SelectedCommand then
        local Status = SelectedCommand.Run(table.unpack(Data.Arguments))
        return Status
    end
end
local Remotes = game.ReplicatedStorage.Remotes
local Velocity = require(game.ReplicatedStorage.Velocity)
local Commands = Velocity.Commands

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    local SelectedCommand = Commands[Data.Command]
    if SelectedCommand then
        local Success, Status = SelectedCommand.Run(table.unpack(Data.Arguments))
        return Success, Status
    end
end
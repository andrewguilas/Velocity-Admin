local Remotes = game.ReplicatedStorage.Remotes
local Commands = require(game.ReplicatedStorage.Modules.Velocity).Commands

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    local SelectedCommand = Commands[Data.Command]
    if SelectedCommand then
        return SelectedCommand.Run(table.unpack(Data.Arguments))
    end
end
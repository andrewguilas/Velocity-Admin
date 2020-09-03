local Remotes = game.ReplicatedStorage.Remotes
local Velocity = require(game.ReplicatedStorage.Velocity)
local Commands = Velocity.Commands

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    local SelectedCommand = Commands[Data.Command]
    if SelectedCommand then
        if #SelectedCommand.Arguments == #Data.Arguments then
            print(Data.Command .. " was fired. Arguments are " .. table.concat(Data.Arguments, ", "))
            local Status = SelectedCommand.Run(table.unpack(Data.Arguments))
            print(Status)
            return Status
        end
    end
end
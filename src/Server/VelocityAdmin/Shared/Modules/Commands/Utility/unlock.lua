local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Unlocks the server so incoming people can join."

Cmd.Arguments = {}

Cmd.Run = function()
    Helper.Data.ServerLocked = nil
    return true, "Server unlocked"
end

----------------------------------------------------------------------

return Cmd
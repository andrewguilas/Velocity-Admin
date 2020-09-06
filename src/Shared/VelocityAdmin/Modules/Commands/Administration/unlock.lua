local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Unocks the server incoming people to join."

Cmd.Arguments = {}

Cmd.Run = function()
    Helper.Data.ServerLocked = nil
    return true, "Server unlocked"
end

----------------------------------------------------------------------

return Cmd
local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Unocks the server incoming people to join."

Cmd.Arguments = {}

Cmd.Run = function()
    Velocity.TempData.ServerLocked = nil
    return true, "Server unlocked"
end

----------------------------------------------------------------------

return Cmd
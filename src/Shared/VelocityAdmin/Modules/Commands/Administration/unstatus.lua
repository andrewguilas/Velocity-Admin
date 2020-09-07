local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Removes the current status."

Cmd.Arguments = {}

Cmd.Run = function()
    Remotes.Announcement:FireAllClients("Status")
    return true, "Status was removed"
end

----------------------------------------------------------------------

return Cmd
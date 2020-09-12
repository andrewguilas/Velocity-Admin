local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

----------------------------------------------------------------------

Cmd.Description = "Removes the current status."

Cmd.Arguments = {}

Cmd.Run = function()
    Remotes.Announcement:FireAllClients("Status")
    return true, "Status was removed"
end

----------------------------------------------------------------------

return Cmd
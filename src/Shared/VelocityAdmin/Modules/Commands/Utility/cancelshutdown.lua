local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

----------------------------------------------------------------------

Cmd.Description = "Cancels the current shut down."

Cmd.Arguments = {}

Cmd.Run = function(CurrentPlayer)
    -- Run Command
    Remotes.Announcement:FireAllClients("Shutdown", "Cancel")
    return true, "Canceling server shutdown"
end

----------------------------------------------------------------------

return Cmd
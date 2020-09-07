local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Shuts down the server in a duration."

Cmd.Arguments = {}

Cmd.Run = function(CurrentPlayer)
    -- Run Command
    Remotes.Announcement:FireAllClients("Shutdown", "Cancel")
    return true, "Canceling server shutdown"
end

----------------------------------------------------------------------

return Cmd
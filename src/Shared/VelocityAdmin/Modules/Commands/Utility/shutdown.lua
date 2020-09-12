local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

----------------------------------------------------------------------

Cmd.Description = "Shuts down the server in a duration."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "delay",
        ["Description"] = "How long until the server is shut down (optional).",
        ["Choices"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Delay)

    -- Checks parameters

    if Delay and not tonumber(Delay) then
        return false, "Delay must be a number"
    end

    -- Run Command
    Remotes.Announcement:FireAllClients("Shutdown", Delay)
    if Delay then
        return true, "Server shutting down in " .. Delay .. " seconds"
    else
        return true, "Server shutting down"
    end

end

----------------------------------------------------------------------

return Cmd
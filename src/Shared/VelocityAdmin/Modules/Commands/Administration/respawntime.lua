local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Changes the default respawn time for all Players."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "duration",
        ["Description"] = "How long it will take for a player to respawn.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Duration)

    -- Check if necessary arguments are there
    if not Duration then
        return false, "Duration Argument Missing"
    end

    Duration = tonumber(Duration)
    if not Duration then
        return false, "Duration argument must be a number"
    end

    -- Run Command
    game.Players.RespawnTime = Duration
    return true, "Respawn duration changed to " .. Duration
end

----------------------------------------------------------------------

return Cmd
local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
----------------------------------------------------------------------

Cmd.Description = "If true, players won't be able to use emotes."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "useemotes",
        ["Description"] = "If players can use emotes.",
        ["Choices"] = {"true", "false"}
    },
}

Cmd.Run = function(CurrentPlayer, useemotes)

    -- Check if necessary arguments are there
    if not useemotes then
        useemotes = "true"
    end

    -- Run Command
    
    if useemotes == "true" then
        game.StarterPlayer.UserEmotesEnabled = true
        return true, "Players can use emotes"
    else
        game.StarterPlayer.UserEmotesEnabled = false
        return true, "Players cannot use emotes"
    end
end

----------------------------------------------------------------------

return Cmd
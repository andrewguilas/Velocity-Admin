local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Changes the game's clock time."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "number",
        ["Description"] = "The number the time will be set to.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Time)

    -- Check if necessary arguments are there
    if not Time then
        return false, "Time Argument Missing"
    end

    Time = tonumber(Time)
    if not Time then
        return false, "Time argument must be a number"
    end

    -- Run Command
    game.Lighting.ClockTime = Time
    return true, "Game time set to " .. Time
end

----------------------------------------------------------------------

return Cmd
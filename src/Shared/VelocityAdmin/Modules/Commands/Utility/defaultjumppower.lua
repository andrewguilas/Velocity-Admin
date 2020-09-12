local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Changes the default jump power.."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "number",
        ["Description"] = "The default jump power of the game.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Number)

    -- Check if necessary arguments are there
    if not Number then
        return false, "Number Argument Missing"
    end

    Number = tonumber(Number)
    if not Number then
        return false, "Number argument must be a number"
    end

    -- Run Command
    game.StarterPlayer.CharacterJumpPower = Number
    return true, "Default Jump Power set to " .. Number
end

----------------------------------------------------------------------

return Cmd
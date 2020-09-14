local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Changes the default walk speed."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "number",
        ["Description"] = "The default walkspeed of the game.",
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
    game.StarterPlayer.CharacterWalkSpeed = Number
    return true, "Default walk speed set to " .. Number
end

----------------------------------------------------------------------

return Cmd
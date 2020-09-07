local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Changes the game's brightness."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "number",
        ["Description"] = "The number the brightness will be set to.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Brightness)

    -- Check if necessary arguments are there
    if not Brightness then
        return false, "Brightness Argument Missing"
    end

    Brightness = tonumber(Brightness)
    if not Brightness then
        return false, "Brightness argument must be a number"
    end

    -- Run Command
    game.Lighting.Brightness = Brightness
    return true, "Game brightness set to " .. Brightness
end

----------------------------------------------------------------------

return Cmd
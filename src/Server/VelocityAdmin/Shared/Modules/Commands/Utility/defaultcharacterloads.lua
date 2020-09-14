local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "If true, characters won't load in."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "characterloads",
        ["Description"] = "If characters should load.",
        ["Choices"] = {"true", "false"}
    },
}

Cmd.Run = function(CurrentPlayer, characterloads)

    -- Check if necessary arguments are there
    if not characterloads then
        characterloads = "true"
    end

    -- Run Command
    
    if characterloads == "true" then
        game.StarterPlayer.LoadCharacterAppearance = true
        return true, "Characters will now load"
    else
        game.StarterPlayer.LoadCharacterAppearance = false
        return true, "Characters will no longer load"
    end
end

----------------------------------------------------------------------

return Cmd
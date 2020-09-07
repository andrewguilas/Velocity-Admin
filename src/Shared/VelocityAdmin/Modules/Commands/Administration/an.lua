local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

----------------------------------------------------------------------

Cmd.Description = "Announces a message to the entire server."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "reason",
        ["Description"] = "Why the server is locked. (optional)",
        ["Choices"] = true,
        ["NoWordLimit"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Text)

    -- Check if necessary arguments are there
    if not Text then
        return false, "Text Argument Missing"
    end

    local success = pcall(function()
        Text = Chat:FilterStringForBroadcast(Text, CurrentPlayer)
    end)

    if not success then
        return false, "Could not filter text" 
    end

    -- Run Command
    Remotes.Announcement:FireAllClients("Announcement", Text)
    return true, "Announcement made: " .. Text

end

----------------------------------------------------------------------

return Cmd
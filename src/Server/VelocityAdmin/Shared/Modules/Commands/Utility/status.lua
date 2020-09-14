local Cmd = {}
local Chat = game:GetService("Chat")
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

----------------------------------------------------------------------

Cmd.Description = "Displays the status to the entire server. Won't be removed unless called."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "text",
        ["Description"] = "The status that will be displayed indefinitely.",
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
    Remotes.Announcement:FireAllClients("Status", Text)
    return true, "Status was made: " .. Text

end

----------------------------------------------------------------------

return Cmd
local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Locks the server preventing incoming people from joining with a reason."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "reason",
        ["Description"] = "Why the server is locked (optional)",
        ["Choices"] = true,
        ["NoWordLimit"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Reason)
    -- Check if necessary arguments are there
    if Reason then
        local Success = pcall(function()
            Reason = Chat:FilterStringForBroadcast(Reason, CurrentPlayer)
        end)

        if not Success then
            return false, "Could not filter Reason" 
        end
    end

    -- Run Command
    if Reason ~= "" then
        Helper.Data.ServerLocked = Reason
        return true, "Server locked for... " .. Reason
    else
        Helper.Data.TempData.ServerLocked = true
        return true, "Server locked"
    end

end

----------------------------------------------------------------------

return Cmd
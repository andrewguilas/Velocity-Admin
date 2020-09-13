local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Kicks the player from the game with a reason."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to kick.",
        ["Choices"] = Helper.GetPlayers
    },
    [2] = {
        ["Title"] = "reason",
        ["Description"] = "Why you want to kick the player (optional).",
        ["Choices"] = true,
        ["NoWordLimit"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, Reason)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    local success = pcall(function()
        Reason = Chat:FilterStringForBroadcast(Reason, CurrentPlayer)
    end)

    if not success then
        return false, "Could not filter Reason" 
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            if Reason then
                p:Kick(Reason)
                table.insert(Info, {
                    Success = true,
                    Status = Player .. " was kicked for " .. Reason
                })
            else
                p:Kick()
                table.insert(Info, {
                    Success = true,
                    Status = Player .. " was kicked"
                })
            end      
        end      
        return Info        
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
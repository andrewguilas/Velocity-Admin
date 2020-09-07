local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Bans a player from the game."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to ban.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "reason",
        ["Description"] = "Why you want to ban the player.",
        ["Choices"] = true,
        ["NoWordLimit"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, Reason)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    local Success = pcall(function()
        Reason = Chat:FilterStringForBroadcast(Reason, CurrentPlayer)
    end)

    if not Success then
        return false, "Could not filter Reason" 
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        for _,p in pairs(Players) do

            local BanStore = DataStoreService:GetDataStore(Settings.Basic.BanScope)
            if not BanStore then
                return false, "Error calling data stores"
            end

            Success = pcall(function()
                if BanStore:GetAsync(p.UserId) then
                    return false, p.Name .. " is already banned."
                end
            end)

            if not Success then
                return false, "Error checking if player is banned."
            end

            Success = pcall(function()
                BanStore:SetAsync(p.UserId, Reason or true)
            end)

            if Success then
                if Reason then
                    p:Kick("BANNED: " .. Reason)
                    return true, Player .. " was banned for " .. Reason
                else
                    p:Kick("BANNED: " .. Reason)
                    return true, Player .. " was banned."
                end   
            else
                return false, "Error banning " .. Player.Name
            end
        end              
    else
        return false, Player .. " is not a valid player."
    end

end
----------------------------------------------------------------------

return Cmd
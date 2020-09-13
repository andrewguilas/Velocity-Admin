local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")
local DataStoreService = game:GetService("DataStoreService")
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)

----------------------------------------------------------------------

Cmd.Description = "Bans a player from all places for a duration."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to ban (username/userID)",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "length",
        ["Description"] = "How long the place will be banned for (prefixes: s, m, h, d, w, m, y, forever)",
        ["Choices"] = true,
    },
    [3] = {
        ["Title"] = "reason",
        ["Description"] = "Why you want to ban the player.",
        ["Choices"] = true,
        ["NoWordLimit"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, Length, Reason)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not Length then
        Length = "forever"
    end

    local SecondsBanned = Helper.GetLength(Length)
    if not SecondsBanned then
        return false, Length .. " is not a valid length"
    end

    local Success = pcall(function()
        Reason = Chat:FilterStringForBroadcast(Reason, CurrentPlayer)
    end)

    if not Success then
        return false, "Could not filter Reason" 
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do

            local BanStore = DataStoreService:GetDataStore(Settings.Basic.BanScope)
            if not BanStore then
                return false, "Error calling data stores"
            end

            Success = pcall(function()
                BanStore:SetAsync(p.UserId, {
                    Reason = Reason or true,
                    PublishedLength = Length,
                    RealLength = SecondsBanned,
                    StartTime = os.time()
                })
            end)

            -- Kicks player with message
            if Reason then
				table.insert(Info, {
					Success = true,
					Status = p.Name .. " was banned from all servers (duration: " .. Length .. ") for " .. Reason
                })
                p:Kick("TEMP BANNED (duration: " .. Length .. "): " .. Reason)
            else
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " was banned from all servers (duration: " .. Length .. ")"
				})
				p:Kick("TEMP BANNED: " .. Reason)
            end  
        end   
        return Info           
    else
        return false, Player .. " is not a valid player."
    end

end
----------------------------------------------------------------------

return Cmd
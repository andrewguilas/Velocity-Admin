local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Returns if a player is friends with another player."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player1",
        ["Description"] = "The first player.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "player2",
        ["Description"] = "The second player. Can be anyone on Roblox.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Player1, Player2)

    -- Check if necessary arguments are there
    if not Player1 then
        return false, "Player 1 Argument Missing"
    elseif not Player2 then
        return false, "Player 2 Argument Missing"
    end

    -- Gets the player ID and name
    local Player2Name, Player2Id
    if tonumber(Player2) then
        Player2Id = Player2
        
        local success = pcall(function()
            Player2Name = game.Players:GetNameFromUserIdAsync(Player2Id)
        end)

        if not success then
            return false, "Error finding username of " .. Player2Id
        end      
    elseif tostring(Player2) then
        Player2Name = Player2
        
        local success = pcall(function()
            Player2Id = game.Players:GetUserIdFromNameAsync(Player2Name)
        end)

        if not success then
            return false, "Error finding user ID of " .. Player2Name
        end
    else
        return false, "Player2 is not a valid argument type."      
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player1, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            if p:IsFriendsWith(Player2Id) then
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " is friends with " .. Player2Name .. " (" .. Player2Id .. ")"
                })
            else
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " is NOT friends with " .. Player2Name .. " (" .. Player2Id .. ")"
                })
            end
        end      
        return Info        
    else
        return false, Player1 .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
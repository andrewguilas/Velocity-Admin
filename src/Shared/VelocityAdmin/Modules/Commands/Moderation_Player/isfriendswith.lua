local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Checks if the player is friends with the user."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player.",
        ["Choices"] = Helper.GetPlayers
    },
    [2] = {
        ["Title"] = "user",
        ["Description"] = "The user.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Player, User)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not User then
        return false, "User Argument Missing"
    end

    -- Gets the player ID and name
    local UserName, UserId
    if tonumber(User) then
        UserId = User
        
        local success = pcall(function()
            UserName = game.Players:GetNameFromUserIdAsync(UserId)
        end)

        if not success then
            return false, "Error finding username of " .. UserId
        end      
    elseif tostring(User) then
        UserName = User
        
        local success = pcall(function()
            UserId = game.Players:GetUserIdFromNameAsync(UserName)
        end)

        if not success then
            return false, "Error finding user ID of " .. UserName
        end
    else
        return false, "User is not a valid argument type."      
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            if p:IsFriendsWith(UserId) then
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " is friends with " .. UserName .. " (" .. UserId .. ")"
                })
            else
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " is NOT friends with " .. UserName .. " (" .. UserId .. ")"
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
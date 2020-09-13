local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Changes player's appearance to user's."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player which will have their character changed.",
        ["Choices"] = Helper.GetPlayers
    },
    [2] = {
        ["Title"] = "user",
        ["Description"] = "The username or user ID of the user player's character will be turned into",
        ["Choices"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, User)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not User then
        return false, "User Argument Missing"
    end

    -- Get target name & id
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
            p.CharacterAppearanceId = UserId
            p:LoadCharacter()
            table.insert(Info, {
                Success = true,
                Status = p.Name .. "'s character was changed to " .. UserName .. " (UserId: " .. UserId ..")"
            })
        end   
        return Info           
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
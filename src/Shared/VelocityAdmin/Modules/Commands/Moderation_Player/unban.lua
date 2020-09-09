local Cmd = {}
local DataStoreService = game:GetService("DataStoreService")
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)

----------------------------------------------------------------------

Cmd.Description = "Unbans the user from all servers."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The user (name/ID) you want to unban.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, User)

    -- Check if necessary arguments are there
    if not User then
        return false, "User Argument Missing"
    end

    -- Gets the Username & UserId
    local UserName, UserId
    if tonumber(User) then
        UserId = User
        
        local success = pcall(function()
            UserName = game.Players:GetNameFromUserIdAsync(UserId)
        end)

        if not success then
            return false, "Error finding username of " .. User
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

        -- Checks if tempbvanned
    if Helper.Data.TempBanned[UserId] then
        Helper.Data.TempBanned[UserId] = false
        return true, UserName .. " (".. UserId .. ") was unbanned."
    end

        -- Gets data store
    local BanStore = DataStoreService:GetDataStore(Settings.Basic.BanScope)
    if not BanStore then
        return false, "Error calling data stores"
    end

        -- Checks if not banned
    local Success = pcall(function()
        if not BanStore:GetAsync(UserId) then
            return true, UserName .. " (".. UserId .. ") is not banned."
        end
    end)

    if not Success then
        return false, "Error checking if player is banned."
    end

        -- Unbans player
    Success = pcall(function()
        BanStore:SetAsync(UserId, false)
    end)

    if Success then
        return true, UserName .. " (".. UserId .. ") was unbanned."
    else
        return false, "Error unbanning " .. UserName .. " (".. UserId .. ")"
    end

end

----------------------------------------------------------------------

return Cmd
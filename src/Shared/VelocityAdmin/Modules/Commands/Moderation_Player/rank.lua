local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Returns the player's rank & role in a group.."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to check the rank of.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "groupid",
        ["Description"] = "The ID of the group.",
        ["Choices"] = true
    },
}

Cmd.Run = function(CurrentPlayer, Player, ID)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not ID then
        return false, "Group ID argument missing"
    elseif not tonumber(ID) then
        return false, "Group ID needs to be a number"
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    local GroupName = game:GetService("GroupService"):GetGroupInfoAsync(ID).Name
    if Players then
        local Info = {}
        for _,p in pairs(Players) do

            local Success = pcall(function()
                local Role, Rank

                local success = pcall(function()
                    Role = p:GetRoleInGroup(ID)
                end)

                if not success then
                    return false, "Error retrieving " .. p.Name .. " 's role in " .. GroupName .. " (" .. ID .. ")"
                end

                success = pcall(function()
                    Rank = p:GetRankInGroup(ID)
                end)

                if not success then
                    return false, "Error retrieving " .. p.Name .. " 's role in " .. GroupName .. " (" .. ID .. ")"
                end

                if Role and Rank then
                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. " 's role in " .. GroupName .. " (" .. ID .. ") is " .. Role .. " (" .. Rank .. ")"
                    })
                end
            end)

            if not Success then
                return false, "Error checking if " .. p.Name .. " is in " .. GroupName .. " (" .. ID .. ")"
            end

        end      
        return Info        
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
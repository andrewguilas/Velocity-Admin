local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Returns if the player is in a specific group."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to check the ID of.",
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
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    local GroupService = game:GetService("GroupService")
    local GroupName = GroupService:GetGroupInfoAsync(ID).Name
    if Players then
        local Info = {}
        for _,p in pairs(Players) do

            local Success = pcall(function()
                if p:IsInGroup(ID) then
                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. " is in " .. GroupName .. " (" .. ID .. ")"
                    })
                else
                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. " is NOT in " .. GroupName .. " (" .. ID .. ")"                       })
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
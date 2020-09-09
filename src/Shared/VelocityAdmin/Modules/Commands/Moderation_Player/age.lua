local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Returns the player's account age."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to check the age of.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
}

Cmd.Run = function(CurrentPlayer, Player, Reason)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            table.insert(Info, {
                Success = true,
                Status = p.Name .. "'s account is " .. p.AccountAge .. " days old."
            })
        end      
        return Info        
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Changes the player's jump power."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to change the jump power of",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "amount",
        ["Description"] = "The amount you want to set the player's jump power to",
        ["Choices"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, Amount)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not Amount then
        return false, "Amount Argument Missing"
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                Hum.JumpPower = Amount

                Info:insert({
                    Success = true,
                    Status = Player .. "'s jump power was changed to " .. Amount
                })
            else

                Info:insert({
                    Success = false,
                    Status = Player .. "'s character does not exist."
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
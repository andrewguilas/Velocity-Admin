local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Damages the player by an amount"

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to damage (username/user ID)",
        ["Choices"] = Helper.GetPlayers
    },
    [2] = {
        ["Title"] = "amount",
        ["Description"] = "The amount of damage that will be dealt to the player.",
        ["Choices"] = {}
    },
}

Cmd.Run = function(CurrentPlayer, Player, Amount)
        
    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    elseif not Amount then
        return false, "Amount Argument Missing"
    end

    if not tonumber(Amount) then
        return false, Amount .. " is not a number"
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                Hum.Health = Hum.Health - Amount

                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " was damaged by " .. Amount .. " HP's."
                })
            else

                table.insert(Info, {
                    Success = false,
                    Status = p.Name .. "'s character does not exist."
                })
            end 
        end              
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
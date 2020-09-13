local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Unequipps the tools the player is holding."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to remove all the tools of.",
        ["Choices"] = Helper.GetPlayers
    },
}

Cmd.Run = function(CurrentPlayer, Player)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                local Tools = {}

                for _,Tool in pairs(p.Character:GetChildren()) do
                    if Tool:IsA("Tool") then
                        table.insert(Tools, Tool.Name)
                    end
                end

                if #Tools > 0 then
                    Hum:UnequipTools()
                    Info:insert({
                        Success = true,
                        Status = Player .. " unequipped... " .. table.concat(Tools, ", ")
                    })
                else
                    Info:insert({
                        Success = true,
                        Status = Player .. " has no tools in their backpack."
                    })
                end
            else
                Info:insert({
                    Success = false,
                    Status = p.Name .. "'s character does not exist.."
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
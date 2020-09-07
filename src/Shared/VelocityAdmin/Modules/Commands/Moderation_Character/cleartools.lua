local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Removes all the tools the player is holding or is in their backpack."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to remove the tools of.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
}

Cmd.Run = function(CurrentPlayer, Player)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                local Tools = {}

                for _,Tool in pairs(p.Character:GetChildren()) do
                    if Tool:IsA("Tool") then
                        table.insert(Tools, Tool.Name)
                        Tool:Destroy()
                    end
                end

                for _,Tool in pairs(p:WaitForChild("Backpack"):GetChildren()) do
                    if Tool:IsA("Tool") then
                        table.insert(Tools, Tool.Name)
                        Tool:Destroy()
                    end
                end

                if #Tools > 0 then
                    return true, "The following tools were removed from " .. Player .. "... " .. table.concat(Tools, ", ")
                else
                    return true, Player .. " has no tools."
                end
            else
                return false, p.Name .. "'s character does not exist.."
            end
        end              
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
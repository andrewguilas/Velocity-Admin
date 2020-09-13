local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Removes all the tools the player is holding or is in their backpack."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to clear the tools of.",
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
                    table.insert(Info, {
                        Success = true,
                        Status = "The following tools were removed from " .. Player .. "... " .. table.concat(Tools, ", ")
                    })
                else
                    table.insert(Info, {
                        Success = true,
                        Status = Player .. " has no tools."
                    })
                end
            else
                table.insert(Info, {
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
local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Changes the player's name to their default name."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to reset the name of.",
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
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                Hum.DisplayName = ""
                
                table.insert(Info, {
                    Success = true,
                    Status = Player .. "'s custom name was removed. Now using the player name."
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
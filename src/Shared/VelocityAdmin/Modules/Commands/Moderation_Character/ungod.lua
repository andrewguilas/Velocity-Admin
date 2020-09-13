local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Sets the player's health to the previous health before being goded."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to ungod (username/user ID)",
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
                if Helper.Data[CurrentPlayer.Name].God then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.MaxHealth, Hum.Health = Helper.Data[CurrentPlayer.Name].God.MaxHealth, Helper.Data[CurrentPlayer.Name].God.Health
                    Helper.Data[CurrentPlayer.Name].God = nil

                    table.insert(Info, {
                        Success = true,
                        Status = Player .. " was ungodded."
                    })
                else
                    table.insert(Info, {
                        Success = true,
                        Status = Player .. " is already ungodded."
                    })
                end
            else
                table.insert(Info, {
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
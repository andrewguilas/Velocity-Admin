local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Removes the player's forcefield."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to remove the forcefield from.",
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
                for _,FF in pairs(Char:GetDescendants()) do
                    if FF:IsA("ForceField") then
                        FF:Destroy()
                    end
                end

                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. "'s forcefields were removed."
                })
            else
                table.insert(Info, {
                    Success = false,
                    Status = p.Name .. "'s character does not exist."
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
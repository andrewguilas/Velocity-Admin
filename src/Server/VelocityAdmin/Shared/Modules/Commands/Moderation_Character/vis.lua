local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Makes the player visible."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to make visible.",
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
                for _,Part in pairs(Helper.Data[CurrentPlayer.Name].InvisItems or {}) do
                    Part.Transparency = 0
                end

                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " made visible."
                })
            else
                table.insert(Info, {
                    Success = false,
                    Status =  Player .. "'s character does not exist."
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
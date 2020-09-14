local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Changes the player's name over their head."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to change the name of.",
        ["Choices"] = Helper.GetPlayers
    },
    [2] = {
        ["Title"] = "Name",
        ["Description"] = "The chosen name (no word limit). If blank, the player's name will be set to their default username. (Optional)",
        ["Choices"] = true,
        ["NoWordLimit"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, Name)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    local success = pcall(function()
        Name = Chat:FilterStringForBroadcast(Name, CurrentPlayer)
    end)

    if not success then
        return false, "Could not filter Name" 
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                if Name and Name ~= "" then
                    Hum.DisplayName = Name

                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. "'s name was changed to " .. Name
                    })
                else
                    Hum.DisplayName = ""

                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. "'s custom name was removed. Now using the player name."
                    })
                end     
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
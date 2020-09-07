local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Changes the player's name over their head."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to change the name of.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "Name",
        ["Description"] = "The chosen name. (No Word Limit)",
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
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")
                if Name and Name ~= "" then
                    Hum.DisplayName = Name
                    return true, Player .. "'s name was changed to " .. Name
                else
                    Hum.DisplayName = ""
                    return true, Player .. "'s custom name was removed. Now using the player name."
                end     
            else
                return false, p.Name .. "'s character does not exist."
            end
        end              
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
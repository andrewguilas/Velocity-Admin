local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Changes player 1's appearance to any user on Roblox: player 2."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player1",
        ["Description"] = "The player which will have their character changed.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
    [2] = {
        ["Title"] = "player2",
        ["Description"] = "What player1 will be turned into.",
        ["Choices"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, Player2)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player 1 Argument Missing"
    elseif not Player2 then
        return false, "Player 2 Argument Missing"
    end

    -- Get target name & id
    local Player2Name, Player2Id

    if tonumber(Player2) then
        Player2Id = Player2
        
        local success = pcall(function()
            Player2Name = game.Players:GetNameFromUserIdAsync(Player2Id)
        end)

        if not success then
            return false, "Error finding username of " .. Player2Id
        end      
    elseif tostring(Player2) then
        Player2Name = Player2
        
        local success = pcall(function()
            Player2Id = game.Players:GetUserIdFromNameAsync(Player2Name)
        end)

        if not success then
            return false, "Error finding user ID of " .. Player2Name
        end
    else
        return false, "Player2 is not a valid argument type."      
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            p.CharacterAppearanceId = Player2Id
            p:LoadCharacter()
            table.insert(Info, {
                Success = true,
                Status = p.Name .. "'s character was changed to " .. Player2Name .. " (UserId: " .. Player2Id ..")"
            })
        end   
        return Info           
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
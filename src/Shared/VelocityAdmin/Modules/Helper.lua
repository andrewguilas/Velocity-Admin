local Helper = {
    Data = {
        Commands = {},
        Helper = {},
        Settings = {},
        TempBanned = {}
    }
}

----------------------------------------------------------------------

local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)

function Helper.FindPlayer(Key, p)
    local Players = {}

    if Key == "all" then
        Players = game.Players:GetPlayers()
    elseif Key == "others" then
        Players = game.Players:GetPlayers()
        Core.TableRemove(Players, p)
    elseif Key == "me" then
        Players = {p}
    elseif Key == "random" then
        Players = game.Players:GetPlayers()
        if Players[1] ~= nil then
            local value = math.random(1,#Players)
            local picked = Players[value]
        end
    elseif Key:find("team:") then
        Key = Key:sub(5,#Key):lower():gsub("%s+", "")

        for _,v in pairs(game:GetService("Teams")) do
            if v.Name:lower():gsub("%s+", "") == Key then
                for _,player in pairs(game.Players:GetPlayers()) do
                    if player.Team.Name == Key then
                        table.insert(Players,player)
                    end
                end
            end
        end
    else
        for _,p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower() == Key:lower() then
                table.insert(Players, p)
            end
        end        
    end

    if #Players > 0 then
        return Players
    end   
end

function Helper.FindSinglePlayer(Key, p)
    if Key == "me" then
        return p
    else
        for _,p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower() == Key:lower() then
                return p
            end
        end        
    end 
end

----------------------------------------------------------------------

return Helper
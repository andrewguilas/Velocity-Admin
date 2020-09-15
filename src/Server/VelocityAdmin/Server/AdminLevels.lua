local module = {}
--------------------------------------

local UI = script.Parent.Parent.UI
local moderators = {}
local admins = {}
local owners = {}
--------------------------------------
game.Players.PlayerAdded:Connect(function(player)
    if table.find(moderators,player.UserId) then
        local UIclone = UI:Clone()
        UIclone.Parent = player.PlayerGui
    elseif table.find(admins,player.UserId) then
        local UIclone = UI:Clone()
        UIclone.Parent = player.PlayerGui
    elseif type(player) == "userdata" and player:IsA("Player") then
        if game.CreatorType == Enum.CreatorType.User then
            if player.UserId == game.CreatorId then 
                local UIclone = UI:Clone()
                UIclone.Parent = player.PlayerGui
            end
        end
    end
end)
return module 
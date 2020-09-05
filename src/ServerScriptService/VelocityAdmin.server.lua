-- // Variables \\ --

local DataStoreService = game:GetService("DataStoreService")
local Settings = require(game.ReplicatedStorage.Modules.Settings)
local Velocity = require(game.ReplicatedStorage.Modules.Velocity)

local Remotes = game.ReplicatedStorage.Remotes
local Commands = Velocity.Commands

-- // Events \\ --

game.Players.PlayerAdded:Connect(function(p)
    Velocity.TempData[p.Name] = {}

    -- Checks if slocked
    local Reason = Velocity.TempData.ServerLocked
    if Reason then
        p:Kick("Server is locked: " .. Reason)
    end

    -- Checks if tempbanned
    Reason = Velocity.TempData.TempBanned[p.UserId]
    if Reason then
        p:Kick("TEMP BANNED: " .. Reason)
    end

    -- Checks if pBanned
    local BanStore = DataStoreService:GetDataStore(Settings.Basic.BanScope)
    pcall(function()
        local Data = BanStore:GetAsync(p.UserId)
        if Data then
            p:Kick("BANNED: " .. Data)
        end
    end)

end)

game.Players.PlayerRemoving:Connect(function(p)
    Velocity.TempData[p.Name] = nil
end)

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    local SelectedCommand = Commands[Data.Command]
    if SelectedCommand then
        return SelectedCommand.Run(p, table.unpack(Data.Arguments))
    end
end
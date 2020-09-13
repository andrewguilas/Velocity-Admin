-- // Variables \\ --

local DataStoreService = game:GetService("DataStoreService")
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

local BanStore = DataStoreService:GetDataStore(Settings.Basic.BanScope)
local Commands = game.ReplicatedStorage.VelocityAdmin.Modules.Commands
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

-- // Events \\ --

game.Players.PlayerAdded:Connect(function(p)
    Helper.Data[p.Name] = {}

    -- Checks if slocked
    local Reason = Helper.Data.ServerLocked
    if Reason then
        p:Kick("Server is locked: " .. Reason)
    end

    -- Checks if tempbanned
    local BanInfo = Helper.Data.TempBanned[p.UserId]
    if BanInfo then      
        print(os.time() - BanInfo.StartTime .. " seconds has passed sinced banned. " .. p.Name .. " was banned for " .. BanInfo.PublishedLength .. " (" .. BanInfo.RealLength .. ")")
        if os.time() - BanInfo.StartTime < BanInfo.RealLength then
            p:Kick("TEMP BANNED (duration: " .. BanInfo.PublishedLength .. "): " .. BanInfo.Reason)
        else
            Helper.Data.TempBanned[p.UserId] = nil
            print(p.Name .. "'s ban was lifted")
        end
    end

    -- Checks if permanently banned
    --local success, msg = pcall(function()
        BanInfo = BanStore:GetAsync(p.UserId)
        if BanInfo then      
            print(os.time() - BanInfo.StartTime .. " seconds has passed sinced banned. " .. p.Name .. " was banned for " .. BanInfo.PublishedLength .. " (" .. BanInfo.RealLength .. ")")
            if os.time() - BanInfo.StartTime < BanInfo.RealLength then
                p:Kick("PERMANENTLY BANNED (duration: " .. BanInfo.PublishedLength .. "): " .. BanInfo.Reason)
            else
                BanStore:SetAsync(p.UserId, false)
                print(p.Name .. "'s ban was lifted")
            end
        end
    --end)

--[[

    if not success then
        warn("Could not check data stores to see if " .. p.Name .. " (" .. p.UserId .. ") was banned.")
        warn(msg)
    end

]]

end)

game.Players.PlayerRemoving:Connect(function(p)
    Helper.Data[p.Name] = nil
end)

Remotes.FireCommand.OnServerInvoke = function(p, Data)
    for _,Heading in pairs(Commands:GetChildren()) do
        for __,Command in pairs(Heading:GetChildren()) do
            if Command.Name == Data.Command then
                return require(Command).Run(p, table.unpack(Data.Arguments))
            end
        end
    end
end
local Module = {}

----------------------------------

-- // Variables \\ --

local DataStoreService = game:GetService("DataStoreService")
local AuditLog = require(script.Parent.AuditLog)
local Settings, SharedHelper, BanStore, Commands

-- // Defaults \\ --

function Module.SendScripts()
    local Velocity = script.Parent.Parent

    local InstancesToBeSent = {
        {Start = Velocity.Shared, End = game.ReplicatedStorage},
        {Start = Velocity.UI, End = game.StarterGui},
        {Start = Velocity.Client, End = game.StarterPlayer.StarterPlayerScripts},
        {Start = Velocity.Server, End = game.ServerScriptService},
    }

    for _,Info in pairs(InstancesToBeSent) do
        Info.Start.Name = "VelocityAdmin"
        Info.Start.Parent = Info.End
    end

    Velocity:Destroy()
    Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
    SharedHelper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
    BanStore = DataStoreService:GetDataStore(Settings.Basic.BanScope)
    Commands = game.ReplicatedStorage.VelocityAdmin.Modules.Commands
end

-- // Bans \\ --

function Module.CheckSlocked(p)
    local Reason = SharedHelper.Data.ServerLocked
    if Reason then
        p:Kick("Server is locked: " .. Reason)
    end
end

function Module.CheckBanned(p)
    local BanInfo = SharedHelper.Data.TempBanned[p.UserId]
    if BanInfo then      
        print(os.time() - BanInfo.StartTime .. " seconds has passed sinced banned. " .. p.Name .. " was banned for " .. BanInfo.PublishedLength .. " (" .. BanInfo.RealLength .. ")")
        if os.time() - BanInfo.StartTime < BanInfo.RealLength then
            p:Kick("TEMP BANNED (duration: " .. BanInfo.PublishedLength .. "): " .. BanInfo.Reason)
        else
            SharedHelper.Data.TempBanned[p.UserId] = nil
            print(p.Name .. "'s ban was lifted")
        end
    end
end

function Module.CheckpBanned(p)
    local success, msg = pcall(function()
        local BanInfo = BanStore:GetAsync(p.UserId)
        if BanInfo then      
            print(p.Name .. " tried to join. " .. os.time() - BanInfo.StartTime .. " seconds has passed sinced banned. " .. p.Name .. " was banned for " .. BanInfo.PublishedLength .. " (" .. BanInfo.RealLength .. ")")
            if os.time() - BanInfo.StartTime < BanInfo.RealLength then
                p:Kick("PERMANENTLY BANNED (duration: " .. BanInfo.PublishedLength .. "): " .. BanInfo.Reason)
            else
                BanStore:SetAsync(p.UserId, false)
                print(p.Name .. "'s ban was lifted")
            end
        end
    end)

    if not success then
        warn("Could not check data stores to see if " .. p.Name .. " (" .. p.UserId .. ") was banned.")
        warn(msg)
    end
end

-- // Handlers \\ --

function Module.PlayerAdded(p)
    SharedHelper.Data[p.Name] = {}
    Module.CheckSlocked(p)
    Module.CheckBanned(p)
    Module.CheckpBanned(p)
end

function Module.PlayerRemoved(p)
    SharedHelper.Data[p.Name] = nil
end

function Module.FireCommand(p, Data)
    for _,Heading in pairs(Commands:GetChildren()) do
        for __,Command in pairs(Heading:GetChildren()) do
            if Command.Name == Data.Command then
                local Log = require(Command).Run(p, table.unpack(Data.Arguments))
                for _,Info in pairs(Log) do
                    AuditLog.AddLog({
                        Details = Info.Status,
                        PerformedBy = p.Name,
                        Type = Info.Success and "Success" or "Error"
                    })
                end
                return Log
            end
        end
    end
end

----------------------------------

return Module
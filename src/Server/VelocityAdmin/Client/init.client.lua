-- Announcement event fired
local Announcement = require(script.Announcement)
local AuditLog = require(script.AuditLog)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

Remotes.Announcement.OnClientEvent:Connect(Announcement.HandleRequest)
Remotes.UpdateAuditLog.OnClientEvent:Connect(AuditLog.OpenUI)

-- Starts client scripts
require(script.Handler).Init()
-- // Variables \ --
local Announcement = require(script.Announcement)
local AuditLog = require(script.AuditLog)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

-- // Events \\ --

Remotes.Announcement.OnClientEvent:Connect(Announcement.HandleRequest)
Remotes.UpdateAuditLog.OnClientEvent:Connect(AuditLog.OpenUI)

-- // Run \\ --

require(script.Handler).Init()
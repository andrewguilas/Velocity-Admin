-- // Variables \\ --

local ServerHelper = require(script.Helper)
local AuditLog = require(script.AuditLog)

-- // Defaults \\ --

ServerHelper.SendScripts()

-- // Events \\ --

game.Players.PlayerAdded:Connect(ServerHelper.PlayerAdded)
game.Players.PlayerRemoving:Connect(ServerHelper.PlayerRemoved)
game.ReplicatedStorage.VelocityAdmin.Remotes.FireCommand.OnServerInvoke = ServerHelper.FireCommand
game.ReplicatedStorage.VelocityAdmin.Remotes.UpdateAuditLog.OnServerInvoke = AuditLog.GetLogs
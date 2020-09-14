-- // Variables \\ --

local ServerHelper = require(script.Helper)

-- // Defaults \\ --

ServerHelper.SendScripts()

-- // Events \\ --

game.Players.PlayerAdded:Connect(ServerHelper.PlayerAdded)
game.Players.PlayerRemoving:Connect(ServerHelper.PlayerRemoved)
game.ReplicatedStorage.VelocityAdmin.Remotes.FireCommand.OnServerInvoke = ServerHelper.FireCommand
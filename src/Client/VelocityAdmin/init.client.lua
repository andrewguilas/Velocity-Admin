local Announcement = require(script.Announcement)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes
Remotes.Announcement.OnClientEvent:Connect(Announcement.NewAnnoncement)

require(script.Handler).Init()
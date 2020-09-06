local Announcement = require(script.Announcement)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes
Remotes.Announcement.OnClientEvent:Connect(Announcement.HandleRequest)

require(script.Handler).Init()
-- Announcement event fired
local Announcement = require(script.Announcement)
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes
Remotes.Announcement.OnClientEvent:Connect(Announcement.HandleRequest)

-- Starts client scripts
require(script.Handler).Init()
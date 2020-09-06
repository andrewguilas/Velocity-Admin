local Module = {}

----------------------------------------

-- // Variables \\ --

local Debris = game:GetService("Debris")
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)

local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes
local p = game.Players.LocalPlayer
local An = p.PlayerGui:WaitForChild("VelocityAdmin").Announcement

-- // Functions \\ --

function Module.NewStatus(Msg)
    local Hint = An:FindFirstChild("Hint")
    if not Hint then
        local NewHint = An.ListLayout.Template:Clone()
        NewHint.TextLabel.Text = Msg
        NewHint.LayoutOrder = 1
        NewHint.Transparency = Settings.Announcement.StatusTransparency
        NewHint.Name = "Hint"
        NewHint.Parent = An
    else
        Hint.TextLabel.Text = Msg
    end
end

function Module.RemoveStatus()
    local Hint = An:FindFirstChild("Hint")
    if Hint then
        Hint:Destroy()
    end
end

function Module.NewAnnouncement(Msg)

    local NewAn = An.ListLayout.Template:Clone()
    NewAn.TextLabel.Text = Msg
    NewAn.Transparency = Settings.Announcement.AnnouncementTransparency
    NewAn.Parent = An

    local MaxDur = Settings.CommandBar.Response.SecondsPerLetter * #Msg
    if MaxDur > Settings.CommandBar.Response.MaxDuration then
        MaxDur = Settings.CommandBar.Response.MaxDuration
    end

    Debris:AddItem(NewAn, MaxDur)
end

function Module.HandleRequest(Type, Msg)
    if Type == "Announcement" then
        Module.NewAnnouncement(Msg)
    elseif Type == "Status" then
        if Msg then
            Module.NewStatus(Msg)
        else
            Module.RemoveStatus()
        end
    end
end

----------------------------------------

return Module
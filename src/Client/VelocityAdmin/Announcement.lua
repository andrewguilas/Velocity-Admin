local Module = {}

----------------------------------------

-- // Variables \\ --

local Debris = game:GetService("Debris")
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
local Velocity = require(game.ReplicatedStorage.VelocityAdmin.Modules.Velocity)

local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes
local p = game.Players.LocalPlayer
local An = p.PlayerGui:WaitForChild("VelocityAdmin").Announcement

local IsShuttingDown

-- // Functions \\ --

    -- Shutdown
function Module.StartShutdown(Delay)
    -- Cancels shutdown if applicable   
    Module.CancelShutdown(Delay)

    local Status = Module.NewStatus("Server shutting down in " .. Delay .. " seconds")
    IsShuttingDown = true
    for Sec = Delay, 0, -1 do
        Status.TextLabel.Text = "Server shutting down in " .. Sec .. " seconds"
        if not IsShuttingDown then
            Status.TextLabel.Text = "Server shutdown canceled."
            break
        end
        wait(1)
    end

    if IsShuttingDown then
        Remotes.FireCommand:InvokeServer({
            Command = "kick",
            Arguments = {"all", "Server shut down"}
        })
    else
        Module.RemoveStatus()
    end
end

function Module.CancelShutdown(Delay)
    IsShuttingDown = false
end

    -- Status
function Module.NewStatus(Msg)
    local Hint = An:FindFirstChild("Hint")
    if not Hint then
        local NewHint = An.ListLayout.Template:Clone()
        NewHint.TextLabel.Text = Msg
        NewHint.LayoutOrder = 1
        NewHint.Transparency = Settings.Announcement.StatusTransparency
        NewHint.Name = "Hint"
        NewHint.Parent = An
        return NewHint
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

    -- Announcement
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

    -- Main
function Module.HandleRequest(Type, Msg)
    if Type == "Announcement" then
        Module.NewAnnouncement(Msg)
    elseif Type == "Status" then
        if Msg then
            Module.NewStatus(Msg)
        else
            Module.RemoveStatus()
        end
    elseif Type == "Shutdown" then
        if Msg == "Cancel" then
            Module.CancelShutdown()
        else
            Module.StartShutdown(Msg)
        end
    end
end

----------------------------------------

return Module
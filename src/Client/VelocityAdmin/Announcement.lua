local Module = {}

----------------------------------------

-- // Variables \\ --

local Debris = game:GetService("Debris")
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)

local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes
local p = game.Players.LocalPlayer
local An = p.PlayerGui:WaitForChild("VelocityAdmin").Announcement

-- // Functions \\ --

function Module.NewHint(Msg)
    local Hint = An:FindFirstChild("Hint")
    if not Hint then
        local NewHint = An.ListLayout.Template:Clone()
        NewHint.TextLabel.Text = Msg
        NewHint.Name = "Hint"
        NewHint.Parent = An
    else
        Hint.TextLabel.Text = Msg
    end
end

function Module.RemoveHint(Msg)
    local Hint = An:FindFirstChild("Hint")
    if Hint then
        Hint:Destroy()
    end
end

function Module.NewAnnoncement(Msg)

    local NewAn = An.ListLayout.Template:Clone()
    NewAn.TextLabel.Text = Msg
    NewAn.Parent = An

    local MaxDur = Settings.CommandBar.Response.SecondsPerLetter * #Msg
    if MaxDur > Settings.CommandBar.Response.MaxDuration then
        MaxDur = Settings.CommandBar.Response.MaxDuration
    end

    Debris:AddItem(NewAn, MaxDur)
end

----------------------------------------

return Module
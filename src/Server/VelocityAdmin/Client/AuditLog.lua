local Module = {}

-------------------------------

-- // Variables \\ --

local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)
local LogUI = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").AuditLog

function Module.OpenUI(Logs)
    LogUI.Visible = true

    local MaxSizes = {
        Date = 0,
        Type = 0,
        PerformedBy = 0,
        Details = 0
    }

    -- Clears all frames
    for _,Frame in pairs(Core.Get(LogUI.Body, "Frame")) do
        Frame:Destroy()
    end

    -- Creates frames
    for i, Log in pairs(Logs) do
        local NewFrame = LogUI.Body.ListLayout.Template:Clone() do
            for Title, Description in pairs(Log) do
                NewFrame[Title].Text = Description

                if NewFrame[Title].TextBounds.X > MaxSizes[Title] then
                    MaxSizes[Title] = NewFrame[Title].TextBounds.X
                end
            end

            NewFrame.LayoutOrder = i
            NewFrame.Parent = LogUI.Body
        end
    end

    for _, Frame in pairs(Core.Get(LogUI.Body, "Frame")) do
        for Type, Size in pairs(MaxSizes) do
            Frame[Type].Size.X.Offset = Size
        end
    end

end

---------------------------------

return Module
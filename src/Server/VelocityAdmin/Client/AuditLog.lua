local Module = {}

-------------------------------

-- // Variables \\ --

local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)
local LogUI = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").AuditLog

-- // Functions \\ --

function Module.CloseUI()
    LogUI.Visible = false
end

function Module.CreateFields(Logs)
    local MaxSizesX = {
        Date = 0,
        Details = 0,
        PerformedBy = 0,
        Type = 0
    }

    -- Clears all frames
    for _,Frame in pairs(Core.Get(LogUI.Body, "Frame")) do
        Frame:Destroy()
    end

    -- Creates frames
    for i, Log in pairs(Logs) do
        local NewFrame = LogUI.Body.ListLayout.Template:Clone() do
            NewFrame.LayoutOrder = i
            NewFrame.Parent = LogUI.Body 

            if i % 2 == 0 then
                NewFrame.BackgroundTransparency = 0.9
            else
                NewFrame.BackgroundTransparency = 0.8
            end

            for Title, Description in pairs(Log) do
                NewFrame.Frame[Title].Text = Description
                
                if Description == "Error" then
                    NewFrame.Frame[Title].TextColor3 = Color3.fromRGB(255, 0, 0)
                elseif Description == "Success" then
                    NewFrame.Frame[Title].TextColor3 = Color3.fromRGB(0, 255, 0)
                end

                if NewFrame.Frame[Title].TextBounds.X > MaxSizesX[Title] then
                    MaxSizesX[Title] = NewFrame.Frame[Title].TextBounds.X
                end
            end      
        end
    end

    for Name, Size in pairs(MaxSizesX) do
        for _,Frame in pairs(Core.Get(LogUI.Body, "Frame")) do
            Frame.Frame[Name].Size = UDim2.new(0, MaxSizesX[Name] + 40, 1, 0)
        end
        LogUI.Heading.Frame[Name].Size = UDim2.new(0, MaxSizesX[Name] + 40, 1, 0)
    end

    LogUI.Body.CanvasSize = UDim2.new(0, 0, 0, LogUI.Body.ListLayout.AbsoluteContentSize.Y)
end

function Module.OpenUI(Logs)
    LogUI.Visible = true
    Module.CreateFields(Logs)
end

---------------------------------

return Module
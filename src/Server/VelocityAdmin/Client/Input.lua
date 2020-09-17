local Module = {}

-------------------------------

-- // Variables \\ --

local RunService = game:GetService("RunService")
local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)
local Handler = require(script.Parent.Handler)
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
local AutoCompleteModule = require(script.Parent.AutoComplete)

local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = CommandBar.AutoComplete

-- // Functions \\ --

Module.InputFunctions = {

    [Settings.CommandBar.OpenKey] = function(Input, Started)
        if not Started then
            return
        end

        CommandBar.Visible = not CommandBar.Visible
        Handler.DisconnectCon("CloseUI")
        if CommandBar.Visible then
            Module.ClearText()
        end
    end,

    [Settings.CommandBar.AutoComplete.UpKey] = function(Input, Started)
        if Started then
            Handler.Keys.Up = Settings.CommandBar.AutoComplete.HoldDelay
            AutoCompleteModule.UpdateSelectedField(-1)
        else
            Handler.Keys.Up = false
        end
    end,
    
    [Settings.CommandBar.AutoComplete.DownKey] = function(Input, Started)
        if Started then
            Handler.Keys.Down = Settings.CommandBar.AutoComplete.HoldDelay
            AutoCompleteModule.UpdateSelectedField(1)
        else
            Handler.Keys.Down = false
        end
    end,
        
    [Settings.CommandBar.ExitKey] = function(Input, Started)
        if not Started then
            return
        end

        Module.CloseUI() 
    end,

    [Settings.CommandBar.AutoComplete.TabKey] = function(Input, Started)
        if not Started then
            return
        end

        -- Executes auto completion
        for _,Frame in pairs(Core.Get(AutoComplete, "Frame")) do
            for __,Field in pairs(Core.Get(Frame, "TextButton")) do
                if Field.IsSelected.Value then
                    AutoCompleteModule.ExecuteAutoComplete(Field)
                    return
                end
            end
        end
    end,

    [Settings.CommandBar.AutoComplete.ReturnKey] = function(Input, Started)
        if not Started then
            return
        end

        -- Executes command
        if AutoCompleteModule.ExecuteCommand() then
            Module.CloseUI()
        end
    end
}

function Module.ClearText()
    TextBox:CaptureFocus()
    RunService.RenderStepped:Wait()
    TextBox.Text = ""
    Handler.Cons.CloseUI = TextBox.InputBegan:Connect(Module.InputChanged)
end

function Module.CloseUI()
    CommandBar.Visible = false
    TextBox:ReleaseFocus()
    Handler.DisconnectCon("CloseUI")
end

function Module.InputChanged(Input, Started)
    -- Checks if the an input is connected to a function
    local PossibleFunction = Module.InputFunctions[Input.KeyCode]
    if PossibleFunction then
        PossibleFunction(Input, Started)
    end
end

function Module.Init()
    local HoldDelay = Settings.CommandBar.AutoComplete.HoldDelay
    while true do

        local Cancel
        if Handler.Keys.Up == HoldDelay or Handler.Keys.Down == HoldDelay then
            wait(Settings.CommandBar.AutoComplete.InitialHoldDelay)
            Cancel = Handler.Keys.Up == HoldDelay and not Handler.Keys.Up or Handler.Keys.Down == HoldDelay and not Handler.Keys.Down
        end

        if not Cancel then
            if Handler.Keys.Up then
                Handler.Keys.Up = Handler.Keys.Up + 1
                AutoCompleteModule.UpdateSelectedField(-1)
            elseif Handler.Keys.Down then
                Handler.Keys.Down = Handler.Keys.Down + 1
                AutoCompleteModule.UpdateSelectedField(1)
            end
            wait(HoldDelay)
        else
            wait(1)
        end
    end
end

-------------------------------

return Module
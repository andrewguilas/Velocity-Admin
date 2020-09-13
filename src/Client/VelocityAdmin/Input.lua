local Module = {}

local RunService = game:GetService("RunService")
local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)
local Handler = require(script.Parent.Handler)
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)
local AutoCompleteModule = require(script.Parent.AutoComplete)

local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = CommandBar.AutoComplete

Module.InputFunctions = {

    [Settings.CommandBar.OpenKey] = function()
        CommandBar.Visible = not CommandBar.Visible
        Handler.DisconnectCon("CloseUI")
        if CommandBar.Visible then
            Module.ClearText()
        end
    end,

    [Settings.CommandBar.AutoComplete.UpKey] = function()
        AutoCompleteModule.UpdateSelectedField(-1)
    end,
    
    [Settings.CommandBar.AutoComplete.DownKey] = function()
        AutoCompleteModule.UpdateSelectedField(1)
    end,
        
    [Settings.CommandBar.ExitKey] = function()
        Module.CloseUI() 
    end,

    [Settings.CommandBar.AutoComplete.UseKey1]= function()
        Module.Returned() 
    end,

    [Settings.CommandBar.AutoComplete.UseKey2] = function()
        Module.Returned() 
    end
}

function Module.ClearText()
    TextBox:CaptureFocus()
    RunService.RenderStepped:Wait()
    TextBox.Text = ""
    Handler.Cons.CloseUI = TextBox.InputBegan:Connect(Module.RunInput)
end

function Module.CloseUI()
    CommandBar.Visible = false
    TextBox:ReleaseFocus()
    Handler.DisconnectCon("CloseUI")
end

function Module.Returned()
    local SelectedField
    for _,Frame in pairs(Core.Get(AutoComplete, "Frame")) do
        for __,Field in pairs(Core.Get(Frame, "TextButton")) do
            if Field.IsSelected.Value then
                AutoCompleteModule.ExecuteAutoComplete(Field)
                return
            end
        end
    end
    
    if AutoCompleteModule.ExecuteCommand() then
        Module.CloseUI()
    end
end

function Module.RunInput(Input)
    -- Checks if the an input is connected to a function
    local PossibleFunction = Module.InputFunctions[Input.KeyCode]
    if PossibleFunction then
        PossibleFunction()
    end
end

return Module
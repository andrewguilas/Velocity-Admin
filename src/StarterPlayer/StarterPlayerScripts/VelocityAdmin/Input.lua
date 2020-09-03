local Module = {}

local RunService = game:GetService("RunService")
local Core = require(game.ReplicatedStorage.Modules.Core)
local Handler = require(script.Parent.Handler)
local Settings = require(script.Parent.Settings)
local AutoCompleteModule = require(script.Parent.AutoComplete)

local CommandBar = game.Players.LocalPlayer.PlayerGui:WaitForChild("VelocityAdmin").CommandBar
local TextBox = CommandBar.TextBox
local AutoComplete = CommandBar.AutoComplete

Module.InputFunctions = {

    [Settings.CommandBar.OpenKey] = function()
        CommandBar.Visible = not CommandBar.Visible
        Handler.DisconnectCon("CloseUI")
        if CommandBar.Visible then
            TextBox:CaptureFocus()
            RunService.RenderStepped:Wait()
            TextBox.Text = ""
            Handler.Cons.CloseUI = TextBox.InputBegan:Connect(Module.RunUI)
        end
    end,

    [Settings.CommandBar.AutoComplete.UpKey] = function()
<<<<<<< Updated upstream
        AutoCompleteModule.HandleAutoComplete(-1)
    end,
    
    [Settings.CommandBar.AutoComplete.DownKey] = function()
        AutoCompleteModule.HandleAutoComplete(1)
=======
        AutoCompleteModule.UpdateSelectedField(-1)
    end,
    
    [Settings.CommandBar.AutoComplete.DownKey] = function()
        AutoCompleteModule.UpdateSelectedField(1)
>>>>>>> Stashed changes
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

function Module.CloseUI()
    CommandBar.Visible = false
    TextBox:ReleaseFocus()
    Handler.DisconnectCon("CloseUI")
end

function Module.Returned()
    local SelectedField
    for _,Field in pairs(Core.Get(AutoComplete, "TextButton")) do
        if Field.IsSelected.Value then
            AutoCompleteModule.ExecuteAutoComplete(Field)
            return
        end
    end

<<<<<<< Updated upstream
    if SelectedField then
        AutoCompleteModule.RunAutoComplete(SelectedField)
    else
        Module.CloseUI()
    end   
=======
    if AutoCompleteModule.ExecuteCommand() then
        Module.CloseUI()
    end
>>>>>>> Stashed changes
end

function Module.RunUI(Input)
    local PossibleFunction = Module.InputFunctions[Input.KeyCode]
    if PossibleFunction then
        PossibleFunction()
    end
end

return Module
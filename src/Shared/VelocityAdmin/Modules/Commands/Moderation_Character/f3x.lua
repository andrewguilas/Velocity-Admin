local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Chat = game:GetService("Chat")

----------------------------------------------------------------------

Cmd.Description = "Gives the player building tools."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player who will receive building tools.",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
    },
}

Cmd.Run = function(CurrentPlayer, Player)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    -- Run Command
    local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
    if Players then 
        local Info = {}
        for _,p in pairs(Players) do
            local Backpack = p:WaitForChild("Backpack")
            local success, errormsg = pcall(function()
                local Asset = game:GetService("InsertService"):LoadAsset(Settings.Basic.Assets["Building Tools"])
                Asset:GetChildren()[1].Parent = Backpack
                Asset:Destroy()
            end)

            if success then
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " was given building tools."
                })
            else
                warn(errormsg)
                table.insert(Info, {
                    Success = false,
                    Status = "Error giving building tools to " .. p.Name
                })
            end
        end      
        return Info        
    else
        return false, Player .. " is not a valid player."
    end

end

----------------------------------------------------------------------

return Cmd
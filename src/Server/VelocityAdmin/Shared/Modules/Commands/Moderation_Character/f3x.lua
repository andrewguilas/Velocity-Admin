local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)
local Settings = require(game.ReplicatedStorage.VelocityAdmin.Modules.Settings)

----------------------------------------------------------------------

Cmd.Description = "Gives the player f3x."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player who will receive the f3x tool",
        ["Choices"] = Helper.GetPlayers
    },
}

Cmd.Run = function(CurrentPlayer, Player)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player Argument Missing"
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then 
        local Info = {}
        for _,p in pairs(Players) do
            local Backpack = p:WaitForChild("Backpack")
            local success, errormsg = pcall(function()
                local Asset = game:GetService("InsertService"):LoadAsset(Settings.Basic.Assets["F3x"])
                Asset:GetChildren()[1].Parent = Backpack
                Asset:Destroy()
            end)

            if success then
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " was given f3x."
                })
            else
                table.insert(Info, {
                    Success = false,
                    Status = "Error giving f3x to " .. p.Name
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
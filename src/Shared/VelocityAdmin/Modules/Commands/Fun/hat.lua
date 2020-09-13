local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Adds an accessory to the player with the given Roblox accessory ID."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to give the accessory to",
        ["Choices"] = Helper.GetPlayers
    },
    [2] = {
        ["Title"] = "ID",
        ["Description"] = "The Roblox ID of the accessory.",
        ["Choices"] = true,
    }
}

Cmd.Run = function(CurrentPlayer, Player, ID)

    -- Check if necessary arguments are there
    if not Player then
        return false, "Player argument Missing"
    elseif not ID then
        return false, "ID argument Missing"
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
        local Info = {}
        for _,p in pairs(Players) do
            local Char = p.Character
            if Char then
                local Hum = Char:WaitForChild("Humanoid")

                local Asset
                local success = pcall(function()
                    Asset = game:GetService("InsertService"):LoadAsset(ID)
                    Asset.Parent = workspace
                end)

                if not success then
                    table.insert(Info, {
                        Success = false,
                        Status = "Error retrieving asset"
                    })
                end

                Hum:AddAccessory(Asset:GetChildren()[1])
                Asset:Destroy()

                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. " was given accessory " .. ID
                })
            else
                table.insert(Info, {
                    Success = false,
                    Status = p.Name .. "'s character does not exist."
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
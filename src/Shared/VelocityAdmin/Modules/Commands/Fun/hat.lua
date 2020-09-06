local Cmd = {}
local Helper = require(game.ReplicatedStorage.VelocityAdmin.Modules.Helper)

----------------------------------------------------------------------

Cmd.Description = "Adds an accessory to the player."

Cmd.Arguments = {
    [1] = {
        ["Title"] = "player",
        ["Description"] = "The player you want to give the accessory to",
        ["Choices"] = function()
            local Players = {}
            for _,p in pairs(game.Players:GetPlayers()) do
                table.insert(Players, p.Name)
            end
            return Players
        end
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
        return false, "Player Argument Missing"
    elseif not ID then
        return false, "ID Argument Missing"
    end

    -- Run Command
    local Players = Helper.FindPlayer(Player, CurrentPlayer)
    if Players then
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
                    return false, "Error retrieving asset"
                end

                Hum:AddAccessory(Asset:GetChildren()[1])
                Asset:Destroy()
                return true, Player .. " given accessory " .. ID
            else
                return false, Player .. "'s character does not exist."
            end   
        end              
    else
        return false, Player .. " is not a valid player."
    end
end

----------------------------------------------------------------------

return Cmd
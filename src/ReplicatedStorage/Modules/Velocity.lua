local Velocity = {
    Commands = {},
    Helper = {},
    Settings = {},
}

local Teams = game:GetService("Teams")
local Core = require(game.ReplicatedStorage.Modules.Core)
local Settings = require(game.ReplicatedStorage.Modules.Settings)

function Velocity.Helper.FindPlayer(Key, p)
    local Players = {}

    if Key == "all" then
        Players = game.Players:GetPlayers()
    elseif Key == "others" then
        Players = game.Players:GetPlayers()
        Core.TableRemove(Players, p)
    elseif Key == "me" then
        Players = {p}
    else
        for _,p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower() == Key:lower() then
                table.insert(Players, p)
            end
        end        
    end

    if #Players > 0 then
        return Players
    end   
end

-- // Character \\ --

-- // Humanoid \\ --

Velocity.Commands.speed = {
    ["Description"] = "Changes a player's walk speed.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to change the walk speed of..",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "walkpeed",
            ["Description"] = "The speed you want to set the player's walkspeed to.",
            ["Choices"] = true,
        }
    },
    ["Run"] = function(CurrentPlayer, Player, Speed)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        elseif not Speed then
            return false, "Speed Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                local Char = p.Character
                if Char then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.WalkSpeed = Speed
                    return true, Player .. "'s speed was changed to " .. Speed
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.jump = {
    ["Description"] = "Makes a player jump.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to make jump.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
    },
    ["Run"] = function(CurrentPlayer, Player)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                local Char = p.Character
                if Char then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.Jump = true
                    return true, Player .. " jumped."
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}


Velocity.Commands.health = {
    ["Description"] = "Changes a player's health.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to change the health of.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "amount",
            ["Description"] = "The health you want to change the player's health to.",
            ["Choices"] = {}
        },
    },
    ["Run"] = function(CurrentPlayer, Player, Amount)
        
        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        elseif not Amount then
            return false, "Amount Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                local Char = p.Character
                if Char then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.Health = Amount
                    return true, Player .. " 's health was changed to " .. Amount
                else
                    return false, Player .. "'s character does not exist."
                end 
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.maxhealth = {
    ["Description"] = "Changes a player's max health.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to change the health of.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "amount",
            ["Description"] = "The health you want to change the player's max health to.",
            ["Choices"] = {}
        },
    },
    ["Run"] = function(CurrentPlayer, Player, Amount)
        
        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        elseif not Amount then
            return false, "Amount Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                local Char = p.Character
                if Char then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.MaxHealth = Amount
                    return true, Player .. " 's max health was changed to " .. Amount
                else
                    return false, Player .. "'s character does not exist."
                end 
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.kill = {
    ["Description"] = "Kills a player.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to kill.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
    },
    ["Run"] = function(CurrentPlayer, Player)
        
        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                local Char = p.Character
                if Char then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.Health = 0
                    return true, Player .. " was killed."
                else
                    return false, Player .. "'s character does not exist."
                end 
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.damage = {
    ["Description"] = "Damages a player.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to damage.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "Amount",
            ["Description"] = "The amount of damage that will be dealt to the player..",
            ["Choices"] = {}
        },
    },
    ["Run"] = function(CurrentPlayer, Player, Amount)
        
        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        elseif not Amount then
            return false, "Amount Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                local Char = p.Character
                if Char then
                    local Hum = Char:WaitForChild("Humanoid")
                    Hum.Health = Hum.Health - Amount
                    return true, Player .. " was damaged by " .. Amount .. " HP's."
                else
                    return false, Player .. "'s character does not exist."
                end 
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

-- // Player \\ --

Velocity.Commands.kick = {
    ["Description"] = "Kicks a player from the game.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to kick.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "reason",
            ["Description"] = "Why you want to kick the player.",
            ["Choices"] = true,
            ["NoWordLimit"] = true,
        }
    },
    ["Run"] = function(CurrentPlayer, Player, Reason)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            for _,p in pairs(Players) do
                if Reason then
                    p:Kick(Reason)
                    return true, Player .. " was kicked for " .. Reason
                else
                    p:Kick()
                    return true, Player .. " was kicked."
                end      
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

-- // Game \\ --

return Velocity
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
            ["Title"] = "amount",
            ["Description"] = "The amount you want to set the player's walkspeed to.",
            ["Choices"] = true,
        }
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
                    Hum.WalkSpeed = Amount
                    return true, Player .. "'s walk speed was changed to " .. Amount
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

Velocity.Commands.jumppower = {
    ["Description"] = "Changes a player's jump power.",
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
            ["Title"] = "amount",
            ["Description"] = "The amount you want to set the player's jump power to.",
            ["Choices"] = true,
        }
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
                    Hum.JumpPower = Amount
                    return true, Player .. "'s jump power was changed to " .. Amount
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.heal = {
    ["Description"] = "Heals a player.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to heal.",
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
            ["Description"] = "The amount of health that will be given to the player..",
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
                    Hum.Health = Hum.Health + Amount
                    return true, Player .. " was healed by " .. Amount .. " HP's."
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
            ["Choices"] = true
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
            ["Description"] = "The amount you want to change the player's max health to.",
            ["Choices"] = true
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
            ["Title"] = "amount",
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

Velocity.Commands.respawntime = {
    ["Description"] = "Changes the default respawn time for all Players.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "duration",
            ["Description"] = "How long it will take for a player to respawn.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Duration)

        -- Check if necessary arguments are there
        if not Duration then
            return false, "Duration Argument Missing"
        end

        Duration = tonumber(Duration)
        if not Duration then
            return false, "Duration argument must be a number"
        end

        -- Run Command
        game.Players.RespawnTime = Duration
        return true, "Respawn duration changed to " .. Duration
    end
}

Velocity.Commands.brightness = {
    ["Description"] = "Changes the game's brightness.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "number",
            ["Description"] = "The number the brightness will be set to.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Brightness)

        -- Check if necessary arguments are there
        if not Brightness then
            return false, "Brightness Argument Missing"
        end

        Brightness = tonumber(Brightness)
        if not Brightness then
            return false, "Brightness argument must be a number"
        end

        -- Run Command
        game.Lighting.Brightness = Brightness
        return true, "Game brightness set to " .. Brightness
    end
}

return Velocity
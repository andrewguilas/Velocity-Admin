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

Velocity.Commands.char = {
    ["Description"] = "Changes player 1's appearance to any user on Roblox: player 2.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player1",
            ["Description"] = "The player which will have their character changed.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "player2",
            ["Description"] = "What player1 will be turned into.",
            ["Choices"] = true,
        }
    },
    ["Run"] = function(CurrentPlayer, Player, Player2)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player 1 Argument Missing"
        elseif not Player2 then
            return false, "Player 2 Argument Missing"
        end

        -- Get target name & id
        local Player2Name, Player2Id

        if tonumber(Player2) then
            Player2Id = Player2
            
            local success = pcall(function()
                Player2Name = game.Players:GetNameFromUserIdAsync(Player2Id)
            end)

            if not success then
                return false, "Error finding username of " .. Player2Id
            end      
        elseif tostring(Player2) then
            Player2Name = Player2
            
            local success = pcall(function()
                Player2Id = game.Players:GetUserIdFromNameAsync(Player2Name)
            end)

            if not success then
                return false, "Error finding user ID of " .. Player2Name
            end
        else
            return false, "Player2 is not a valid argument type."      
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            local Info = {}
            for _,p in pairs(Players) do
                p.CharacterAppearanceId = Player2Id
                p:LoadCharacter()
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. "'s character was changed to " .. Player2Name .. " (UserId: " .. Player2Id ..")"
                })
            end   
            return Info           
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.re = {
    ["Description"] = "Resets the character, backpack, playerGui.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player with the character you want to load.",
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
                p:LoadCharacter()
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.invis = {
    ["Description"] = "Makes a player invisible.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to make invisible.",
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
                    for _,Part in pairs(Char:GetDescendants()) do
                        pcall(function()
                            Part.Transparency = 1
                        end)
                    end
                    return true, Player .. " made invisible."
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.vis = {
    ["Description"] = "Makes a player visible.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to make visible.",
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
                    for _,Part in pairs(Char:GetDescendants()) do
                        pcall(function()
                            Part.Transparency = 0
                        end)
                    end
                    return true, Player .. " made visible."
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.ff = {
    ["Description"] = "Gives a player a forcefield.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to give forcefield.",
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
                    local FF = Instance.new("ForceField")
                    FF.Parent = Char
                    return true, Player .. " given a forcefield."
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.unff = {
    ["Description"] = "Removes a forcefield from a player if any.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to remove a forcefield from.",
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
                    for _,FF in pairs(Char:GetDescendants()) do
                        if FF:IsA("ForceField") then
                            FF:Destroy()
                        end
                    end
                    return true, Player .. "'s forcefields were removed."
                else
                    return false, Player .. "'s character does not exist."
                end   
            end              
        else
            return false, Player .. " is not a valid player."
        end

    end
}

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

Velocity.Commands.age = {
    ["Description"] = "Returns the player's account age.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to check the age of.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
    },
    ["Run"] = function(CurrentPlayer, Player, Reason)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        if Players then
            local Info = {}
            for _,p in pairs(Players) do
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. "'s account is " .. p.AccountAge .. " days old."
                })
            end      
            return Info        
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.id = {
    ["Description"] = "Returns the player's user ID.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to check the ID of.",
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
            local Info = {}
            for _,p in pairs(Players) do
                table.insert(Info, {
                    Success = true,
                    Status = p.Name .. "'s user ID is " .. p.UserId
                })
            end      
            return Info        
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.isfriendswith = {
    ["Description"] = "Returns if a player is friends with another player..",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player1",
            ["Description"] = "The first player.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "player2",
            ["Description"] = "The second player. Can be anyone on Roblox.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Player1, Player2)

        -- Check if necessary arguments are there
        if not Player1 then
            return false, "Player 1 Argument Missing"
        elseif not Player2 then
            return false, "Player 2 Argument Missing"
        end

        -- Gets the player ID and name
        local Player2Name, Player2Id
        if tonumber(Player2) then
            Player2Id = Player2
            
            local success = pcall(function()
                Player2Name = game.Players:GetNameFromUserIdAsync(Player2Id)
            end)

            if not success then
                return false, "Error finding username of " .. Player2Id
            end      
        elseif tostring(Player2) then
            Player2Name = Player2
            
            local success = pcall(function()
                Player2Id = game.Players:GetUserIdFromNameAsync(Player2Name)
            end)

            if not success then
                return false, "Error finding user ID of " .. Player2Name
            end
        else
            return false, "Player2 is not a valid argument type."      
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player1, CurrentPlayer)
        if Players then
            local Info = {}
            for _,p in pairs(Players) do
                if p:IsFriendsWith(Player2Id) then
                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. " is friends with " .. Player2Name .. " (" .. Player2Id .. ")"
                    })
                else
                    table.insert(Info, {
                        Success = true,
                        Status = p.Name .. " is NOT friends with " .. Player2Name .. " (" .. Player2Id .. ")"
                    })
                end
            end      
            return Info        
        else
            return false, Player1 .. " is not a valid player."
        end

    end
}

Velocity.Commands.isingroup = {
    ["Description"] = "Returns if the player is in a specific group.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to check the ID of.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "groupid",
            ["Description"] = "The ID of the group.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Player, ID)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        elseif not ID then
            return false, "Group ID argument missing"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        local GroupService = game:GetService("GroupService")
        local GroupName = GroupService:GetGroupInfoAsync(ID).Name
        if Players then
            local Info = {}
            for _,p in pairs(Players) do

                local Success = pcall(function()
                    if p:IsInGroup(ID) then
                        table.insert(Info, {
                            Success = true,
                            Status = p.Name .. " is in " .. GroupName .. " (" .. ID .. ")"
                        })
                    else
                        table.insert(Info, {
                            Success = true,
                            Status = p.Name .. " is NOT in " .. GroupName .. " (" .. ID .. ")"                       })
                    end
                end)

                if not Success then
                    return false, "Error checking if " .. p.Name .. " is in " .. GroupName .. " (" .. ID .. ")"
                end

            end      
            return Info        
        else
            return false, Player .. " is not a valid player."
        end

    end
}

Velocity.Commands.rank = {
    ["Description"] = "Returns the player's rank & role in a group.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "player",
            ["Description"] = "The player you want to check the rank of.",
            ["Choices"] = function()
                local Players = {}
                for _,p in pairs(game.Players:GetPlayers()) do
                    table.insert(Players, p.Name)
                end
                return Players
            end
        },
        [2] = {
            ["Title"] = "groupid",
            ["Description"] = "The ID of the group.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Player, ID)

        -- Check if necessary arguments are there
        if not Player then
            return false, "Player Argument Missing"
        elseif not ID then
            return false, "Group ID argument missing"
        elseif not tonumber(ID) then
            return false, "Group ID needs to be a number"
        end

        -- Run Command
        local Players = Velocity.Helper.FindPlayer(Player, CurrentPlayer)
        local GroupName = game:GetService("GroupService"):GetGroupInfoAsync(ID).Name
        if Players then
            local Info = {}
            for _,p in pairs(Players) do

                local Success = pcall(function()
                    local Role, Rank

                    local success = pcall(function()
                        Role = p:GetRoleInGroup(ID)
                    end)

                    if not success then
                        return false, "Error retrieving " .. p.Name .. " 's role in " .. GroupName .. " (" .. ID .. ")"
                    end

                    success = pcall(function()
                        Rank = p:GetRankInGroup(ID)
                    end)

                    if not success then
                        return false, "Error retrieving " .. p.Name .. " 's role in " .. GroupName .. " (" .. ID .. ")"
                    end

                    if Role and Rank then
                        table.insert(Info, {
                            Success = true,
                            Status = p.Name .. " 's role in " .. GroupName .. " (" .. ID .. ") is " .. Role .. " (" .. Rank .. ")"
                        })
                    end
                end)

                if not Success then
                    return false, "Error checking if " .. p.Name .. " is in " .. GroupName .. " (" .. ID .. ")"
                end

            end      
            return Info        
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

Velocity.Commands.time = {
    ["Description"] = "Changes the game's clock time.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "number",
            ["Description"] = "The number the time will be set to.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Time)

        -- Check if necessary arguments are there
        if not Time then
            return false, "Time Argument Missing"
        end

        Time = tonumber(Time)
        if not Time then
            return false, "Time argument must be a number"
        end

        -- Run Command
        game.Lighting.ClockTime = Time
        return true, "Game time set to " .. Time
    end
}

Velocity.Commands.defaultjumppower = {
    ["Description"] = "Changes the default jump power.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "number",
            ["Description"] = "The default jump power of the game.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Number)

        -- Check if necessary arguments are there
        if not Number then
            return false, "Number Argument Missing"
        end

        Number = tonumber(Number)
        if not Number then
            return false, "Number argument must be a number"
        end

        -- Run Command
        game.StarterPlayer.CharacterJumpPower = Number
        return true, "Default Jump Power set to " .. Number
    end
}

Velocity.Commands.defaultspeed = {
    ["Description"] = "Changes the default walk speed.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "number",
            ["Description"] = "The default walk speed of the game.",
            ["Choices"] = true
        },
    },
    ["Run"] = function(CurrentPlayer, Number)

        -- Check if necessary arguments are there
        if not Number then
            return false, "Number Argument Missing"
        end

        Number = tonumber(Number)
        if not Number then
            return false, "Number argument must be a number"
        end

        -- Run Command
        game.StarterPlayer.CharacterWalkSpeed = Number
        return true, "Default walk speed set to " .. Number
    end
}

Velocity.Commands.defaultcharacterloads = {
    ["Description"] = "If true, characters won't load in.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "characterloads",
            ["Description"] = "If characters should load.",
            ["Choices"] = {"true", "false"}
        },
    },
    ["Run"] = function(CurrentPlayer, characterloads)

        -- Check if necessary arguments are there
        if not characterloads then
            return false, "characterloads Argument Missing"
        end

        -- Run Command
        
        if characterloads == "true" then
            game.StarterPlayer.LoadCharacterAppearance = true
            return true, "Characters will now load"
        else
            game.StarterPlayer.LoadCharacterAppearance = false
            return true, "Characters will no longer load"
        end
    end
}

Velocity.Commands.useemotes = {
    ["Description"] = "If true, player's won't be able to use emotes.",
    ["Arguments"] = {
        [1] = {
            ["Title"] = "useemotes",
            ["Description"] = "If players can use emotes.",
            ["Choices"] = {"true", "false"}
        },
    },
    ["Run"] = function(CurrentPlayer, useemotes)

        -- Check if necessary arguments are there
        if not useemotes then
            return false, "useemotes Argument Missing"
        end

        -- Run Command
        
        if useemotes == "true" then
            game.StarterPlayer.UserEmotesEnabled = true
            return true, "Players can use emotes"
        else
            game.StarterPlayer.UserEmotesEnabled = false
            return true, "Players cannot use emotes"
        end
    end
}

return Velocity
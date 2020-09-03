local Velocity = {
    Commands = {
        kick = {
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
            ["Run"] = function(Player, Reason)

                -- Check if necessary arguments are there
                if not Player then
                    return false, "Player Argument Missing"
                end

                -- Run Command
				local p = game.Players:FindFirstChild(Player)
				if p then
                    if Reason then
                        p:Kick(Reason)
                        return true, Player .. " was kicked for " .. Reason
                    else
                        p:Kick()
                        return true, Player .. " was kicked."
                    end                    
                else
                    return false, Player .. " is not found in the player list."
                end

			end
        },
        speed = {
            ["Description"] = "Changes a player's walk speed.",
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
                    ["Title"] = "walkpeed",
                    ["Description"] = "The speed you want to set the player's walkspeed to.",
                    ["Choices"] = true,
                }
            },
            ["Run"] = function(Player, Speed)

                -- Check if necessary arguments are there
                if not Player then
                    return false, "Player Argument Missing"
                elseif not Speed then
                    return false, "Speed Argument Missing"
                end

                -- Run Command
                local p = game.Players:FindFirstChild(Player)
                if p then
                    local Char = p.Character
                    if Char then
                        local Hum = Char:WaitForChild("Humanoid")
                        Hum.WalkSpeed = Speed
                        return true, Player .. "'s speed was changed to " .. Speed
                    else
                        return false, Player .. "'s character does not exist."
                    end
                else
                    return false, Player .. " is not found in the player list."
                end

            end
        },
        kill = {
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
            ["Run"] = function(Player)
                
                -- Check if necessary arguments are there
                if not Player then
                    return false, "Player Argument Missing"
                end

                -- Run Command
                local p = game.Players:FindFirstChild(Player)
                if p then
                    local Char = p.Character
                    if Char then
                        local Hum = Char:WaitForChild("Humanoid")
                        Hum.Health = 0
                        return true, Player .. " was killed."
                    else
                        return false, Player .. "'s character does not exist."
                    end
                else
                    return false, Player .. " is not found in the player list."
                end

            end
        },
	},
}

return Velocity
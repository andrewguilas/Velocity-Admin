local Velocity = {
    Commands = {
        Kick = {
            ["Startup"] = "kick",
            ["Description"] = "Kicks a player from the game.",
            ["Arguments"] = {
                [1] = {
                    ["Title"] = "Player",
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
                    ["Title"] = "Reason",
                    ["Description"] = "Why you want to kick the player.",
                    ["Choices"] = true,
                }
			},
			["Run"] = function(Player, Reason)
				
			end
        },
        Speed = {
            ["Startup"] = "speed",
            ["Description"] = "Changes a player's walk speed.",
            ["Arguments"] = {
                [1] = {
                    ["Title"] = "Player",
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
                    ["Title"] = "WalkSpeed",
                    ["Description"] = "The speed you want to set the player's walkspeed to.",
                    ["Choices"] = true,
                }
            },
            ["Run"] = function(Player, Speed)
                
            end
        }
	},
}

return Velocity
local LENGTH_SUFFIXES = {"s", "mi", "h", "d", "w", "mo", "y", "forever"}
local MAX_DETECTION_DIST = math.huge

local Teams = game:GetService("Teams")
local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)
local Helper = {
    Data = {
        Commands = {},
        Helper = {},
        Settings = {},
        TempBanned = {}
    }
}

----------------------------------------------------------------------


-- Players

function Helper.GetPlayers(CurrentPlayer)
    local Players = {
        ["all"] = "",
        ["others"] = "",
    }

    local Dist, ClosestPlayer = MAX_DETECTION_DIST, nil
    for _,p in pairs(game.Players:GetPlayers()) do
        -- Creates all
        Players["all"] = Players["all"] .. p.Name .. " (" .. p.UserId .. "), "

        -- Creates others
        if p ~= CurrentPlayer then
            Players["others"] = Players["others"] .. p.Name .. " (" .. p.UserId .. "), "
        end

        -- Creates single players
        Players[p.Name] = "UserID: " .. p.UserId

        -- Gets closests player
        if p.Character and CurrentPlayer.Character then
            local pDist = Core.Mag(p.Character:WaitForChild("HumanoidRootPart"), CurrentPlayer.Character:WaitForChild("HumanoidRootPart"))
            if pDist < MAX_DETECTION_DIST and p ~= CurrentPlayer then
                ClosestPlayer = p
                Dist = pDist
            end
        end

    end

    -- Creates closest Player
    if ClosestPlayer then
        Players["closest_player"] = ClosestPlayer.Name .. " (" .. ClosestPlayer.UserId .. ")"
    end

    -- Finishes others
    if not Players["others"] then
        Players["others"] = nil
    end

    -- Creates team
    for _,Team in pairs(Teams:GetChildren()) do
        local TeamName = Team.Name:lower():gsub("%s+", "")
        Players["team:" .. TeamName] = ""
        for __,TeamMember in pairs(Team:GetPlayers()) do
            Players["team:" .. TeamName] = Players["team:" .. TeamName] .. TeamMember.Name .. " (" .. TeamMember.UserId .. "), "
        end
    end

    return Players
end

function Helper.FindPlayer(Key, CurrentPlayer)
    local Players = {}

    if Key == "all" then
        Players = game.Players:GetPlayers()
    elseif Key == "others" then
        Players = game.Players:GetPlayers()
        Core.TableRemove(Players, CurrentPlayer)
    elseif Key == "me" then
        Players = {CurrentPlayer}
    elseif Key == "random" then
        table.insert(Players, game.Players:GetPlayers()[math.random(#game.Players:GetPlayers())])
    elseif Key:find("team:") then
        for _,Team in pairs(game:GetService("Teams"):GetChildren()) do
            if Team.Name:lower():gsub("%s+", "") == Key:sub(6, #Key):lower():gsub("%s+", "") then
                Players = Team:GetPlayers()
            end
        end
    elseif Key:find(",") then
        for _,pName in pairs(Key:split(",")) do
            for __,p in pairs(game.Players:GetPlayers()) do
                if p.Name:lower() == pName:lower() then
                    table.insert(Players, p)
                end
            end
        end
    else
        for _,p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower() == Key:lower() then
                table.insert(Players, p)
                break
            end
        end        
    end

    if #Players > 0 then
        return Players
    end   
end

function Helper.FindSinglePlayer(Key, p)
    if Key == "me" then
        return p
    else
        for _,p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower() == Key:lower() then
                return p
            end
        end        
    end 
end

-- Lengths

local CalculateLength = {
    ["s"] = function(Length)
        return tonumber(Length:sub(1, #Length-1))
    end,

    ["mi"] = function(Length)
        return tonumber(Length:sub(1, #Length-2) * 60)
    end,

    ["h"] = function(Length)
        return tonumber(Length:sub(1, #Length-1) * 3600)
    end,

    ["d"] = function(Length)
        return tonumber(Length:sub(1, #Length-1) * 86400)
    end,

    ["w"] = function(Length)
        return tonumber(Length:sub(1, #Length-1) * 604800)
    end,

    ["mo"] = function(Length)
        return tonumber(Length:sub(1, #Length-2) * 2628000)
    end,

    ["y"] = function(Length)
        return tonumber(Length:sub(1, #Length-1) * 31536000)
    end,

    ["forever"] = function(Length)
        return math.huge
    end,
}

function Helper.GetLength(Length)
    Length = Length:lower()
    for _,Suffix in pairs(LENGTH_SUFFIXES) do
		if Length:find(Suffix) then
			return CalculateLength[Suffix](Length)
        end
    end
end

----------------------------------------------------------------------

return Helper
local LENGTH_SUFFIXES = {"s", "mi", "h", "d", "w", "mo", "y", "forever"}
local Helper = {
    Data = {
        Commands = {},
        Helper = {},
        Settings = {},
        TempBanned = {}
    }
}

----------------------------------------------------------------------

local Core = require(game.ReplicatedStorage.VelocityAdmin.Modules.Core)

-- Players

function Helper.FindPlayer(Key, p)
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
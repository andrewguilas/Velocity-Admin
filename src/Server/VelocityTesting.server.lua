-- This scripts creates instances & sets values for a suitable testing environment

-- // Settings \\ --

-- Team settings
local TEAM_COLORS = {"Really red", "Really blue"}
local AUTO_ASSIGNABLE_TEAM_COLORS = {"Really red", "Really blue"}
local NEUTRAL_TEAM_COLORS = {}

-- Team spawn location settings
local SPAWN_LOCATION_DIST_MULTIPLIER = 16
local SPAWN_LOCATION_FORCEFIELD_DURATION = 1
local SPAWN_LOCATION_SIZE = Vector3.new(14, 1, 14)
local CHANGE_TEAM_ON_TOUCH = true

-- // Variables \\ --

local Teams = game:GetService("Teams")

-- // Run \\ --

-- Creates teams
for i, TeamColor in pairs(TEAM_COLORS) do

    -- Creates team
    local NewTeam = Instance.new("Team") do
        NewTeam.Name = TeamColor
        NewTeam.TeamColor = BrickColor.new(TeamColor)
        NewTeam.AutoAssignable = table.find(AUTO_ASSIGNABLE_TEAM_COLORS, TeamColor)
        NewTeam.Parent = Teams
    end

    -- Creates spawn location
    local TeamSpawn = Instance.new("SpawnLocation") do
        TeamSpawn.Name = TeamColor
        TeamSpawn.AllowTeamChangeOnTouch = CHANGE_TEAM_ON_TOUCH
        TeamSpawn.Duration = SPAWN_LOCATION_FORCEFIELD_DURATION
        TeamSpawn.Neutral = table.find(NEUTRAL_TEAM_COLORS, TeamColor)
        TeamSpawn.Anchored = true
        TeamSpawn.TopSurface = Enum.SurfaceType.Smooth
        TeamSpawn.BrickColor, TeamSpawn.TeamColor = BrickColor.new(TeamColor), BrickColor.new(TeamColor)
        TeamSpawn.Size = SPAWN_LOCATION_SIZE
        TeamSpawn.Parent = workspace
        TeamSpawn.Position = Vector3.new(0, 0.5, i * SPAWN_LOCATION_DIST_MULTIPLIER)
    end

end
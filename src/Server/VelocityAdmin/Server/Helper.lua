local Module = {}

function Module.SendScripts()
    local Velocity = script.Parent.Parent

    local InstancesToBeSent = {
        {Start = Velocity.Shared, End = game.ReplicatedStorage},
        {Start = Velocity.UI, End = game.StarterGui},
        {Start = Velocity.Client, End = game.StarterPlayer.StarterPlayerScripts},
        {Start = Velocity.Server, End = game.ServerScriptService},
    }

    for _,Info in pairs(InstancesToBeSent) do
        Info.Start.Name = "VelocityAdmin"
        Info.Start.Parent = Info.End
    end

    Velocity:Destroy()
end

return Module
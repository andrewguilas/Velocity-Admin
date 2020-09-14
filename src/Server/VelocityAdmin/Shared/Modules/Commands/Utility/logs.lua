local Cmd = {}
local Remotes = game.ReplicatedStorage.VelocityAdmin.Remotes

----------------------------------------------------------------------

Cmd.Description = "Opens the audit log"

Cmd.Arguments = {}

Cmd.Run = function(CurrentPlayer)
    local AuditLog = require(game.ServerScriptService.VelocityAdmin.AuditLog)
    Remotes.UpdateAuditLog:FireClient(CurrentPlayer, AuditLog.Logs)
    return true, "Audit log opened"
end

----------------------------------------------------------------------

return Cmd
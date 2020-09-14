local Module = {}

----------------------------------

Module = {
    Logs = {},
    Settings = {
        MaxLogs = 100
    }
}

function Module.CheckSize()
    if #Module.Logs >= Module.Settings.MaxLogs then
        for x = 1, #Module.Logs - Module.Settings.MaxLogs do
            table.remove(Module.Logs, 1)
        end
    end
end

function Module.GetDate()
    local Date = os.date("*t", os.time())
    return (Date.month .. "/" .. Date.day .. "/" .. Date.year .. "    " .. Date.hour .. ":" .. Date.min .. ":" .. Date.sec)
end

function Module.AddLog(Info)
    Info.Date = Module.GetDate()
    table.insert(Module.Logs, Info)
    Module.CheckSize()
end

----------------------------------

return Module
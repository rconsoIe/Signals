local Signals = {}
Signals.version = nil

function Signals.init()
    local path
    if Signals.version then
        path = "@" .. Signals.version .. "/main.lua"
    else
        path = "main/main.lua"
    end

    local url =
        "https://raw.githubusercontent.com/rconsoIe/Signals/refs/heads/main/" .. path

    local ok, impl = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if not ok then
        error("Signals: failed to load implementation (" .. path .. ")")
    end

    return impl
end

return Signals

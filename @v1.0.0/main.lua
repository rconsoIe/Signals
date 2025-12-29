local Signals = {}
Signals.debug = false

local listeners = {}

local function dprint(...)
    if Signals.debug then
        print("[Signals]", ...)
    end
end

local function getBucket(name)
    local b = listeners[name]
    if not b then
        b = {}
        listeners[name] = b
    end
    return b
end

function Signals.on(name, fn)
    local bucket = getBucket(name)
    bucket[fn] = true
    dprint("on", name)
    return fn
end

function Signals.once(name, fn)
    local wrapper
    wrapper = function(...)
        Signals.off(name, wrapper)
        fn(...)
    end
    Signals.on(name, wrapper)
end

function Signals.off(name, fn)
    local bucket = listeners[name]
    if bucket then
        bucket[fn] = nil
        dprint("off", name)
    end
end

function Signals.emit(name, ...)
    local bucket = listeners[name]
    if not bucket then return end
    dprint("emit", name)
    for fn in pairs(bucket) do
        fn(...)
    end
end

function Signals.clear(name)
    listeners[name] = nil
    dprint("clear", name)
end

return Signals

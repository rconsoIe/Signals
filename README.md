# Signals

Lightweight client-side signal / event system for Roblox.

Signals provides a simple way for client scripts to communicate without using BindableEvents, `_G`, or tight coupling between modules.

Pure Lua. Client-only. No Instances created.

---

## What it does

- Provides a centralized client-side event bus
- Replaces BindableEvents and ad-hoc callbacks
- Allows decoupled communication between systems
- Has predictable performance and low overhead
- Optional debug logging

---

## What it does NOT do

- It does not replicate data
- It does not replace server networking
- It does not add security
- It does not manage state by itself

Signals is about communication, not authority.

---

## Setup

Load Signals using HttpGet:

```lua
local Signals = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/rconsoIe/Signals/refs/heads/main/loader.lua"
))()

Optional version selection:

Signals.version = "v1.0.0"

Signals = Signals.init()
```

If no version is specified, the latest version is loaded by default.

---

## Basic usage

### Signals.on

Registers a listener for a signal.

```lua
Signals.on(name, callback)
```

Example:

```lua
Signals.on("HealthChanged", function(hp)
    print("new health:", hp)
end)
```

---

### Signals.emit

Emits a signal and calls all registered listeners.

```lua
Signals.emit(name, ...)
```

Example:

```lua
Signals.emit("HealthChanged", 80)
```

All listeners registered under "HealthChanged" will be called with the provided arguments.

---

### Signals.once

Registers a listener that runs only once, then automatically unregisters.

```lua
Signals.once(name, callback)
```

Example:

```lua
Signals.once("Initialized", function()
    print("ran once")
end)
```

---

### Signals.off

Removes a specific listener from a signal.

```lua
Signals.off(name, callback)
```

Example:

```lua
local fn = function()
    print("hello")
end

Signals.on("Test", fn)
Signals.off("Test", fn)
```

---

### Signals.clear

Removes all listeners for a signal.

```lua
Signals.clear(name)
```

Example:

```lua
Signals.clear("HealthChanged")
```

---

## Debug mode

Signals supports optional debug logging.

```
Signals.debug = true
```

When enabled, Signals will print:
- listener registration
- listener removal
- signal emissions
- signal clearing

Debug output is prefixed with `[Signals]`.

---

## Performance notes

- No Instances are created
- No RBXScriptSignal connections are used
- Listener storage is table-based and O(1)
- Emits are fast and predictable
- Suitable for frequent client-side events

Signals is significantly lighter than BindableEvents for client-only logic.

---

## Recommended usage

Use Signals for:
- UI communication
- Client state changes
- Input notifications
- Animation triggers
- System decoupling

Avoid using Signals for:
- Server authority
- Security checks
- Long-running or blocking operations

---

## Example (realistic)

```
Signals.on("InventoryUpdated", function(inv)
    print("inventory size:", #inv)
end)

Signals.emit("InventoryUpdated", inventoryTable)
```

---

## Design goals

- Minimal API
- Predictable behavior
- Easy cleanup
- No magic or hidden side effects

Signals is intentionally small and focused.

---

## Notes

- Signals is client-only
- Signals is synchronous
- Listener execution order is not guaranteed
- Keep listeners lightweight

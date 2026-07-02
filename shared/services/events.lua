local Events = {}

Events.Listeners = {}

function Events:On(eventName, callback)
    if type(callback) ~= "function" then
        Logger:Error(("Event '%s' callback is not a function."):format(eventName))
        return false
    end

    self.Listeners[eventName] = self.Listeners[eventName] or {}

    table.insert(self.Listeners[eventName], callback)

    Logger:Debug(("Registered listener for '%s'"):format(eventName))

    return true
end

function Events:Emit(eventName, data)
    local listeners = self.Listeners[eventName]

    if not listeners then
        Logger:Debug(("No listeners for '%s'"):format(eventName))
        return
    end

    Logger:Debug(("Emitting '%s' to %d listener(s)"):format(
        eventName,
        #listeners
    ))

    for _, callback in ipairs(listeners) do
        local success, err = pcall(callback, data)

        if not success then
            Logger:Error(("Listener for '%s' failed: %s"):format(
                eventName,
                err
            ))
        end
    end
end

OBJobs.Events = Events
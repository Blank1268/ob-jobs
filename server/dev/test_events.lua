if not Config.DeveloperMode then
    return
end

CreateThread(function()
    Wait(1500)

    OBJobs.Events:On("test.event", function(data)
        Logger:Info(("Test event received! Message: %s"):format(data.message))
    end)

    Logger:Debug("Test event listener registered.")
end)

RegisterCommand("obevent", function(source)
    OBJobs.Events:Emit("test.event", {
        message = "Hello from the Event Bus!"
    })

    if source ~= 0 then
        TriggerClientEvent(
            "ob_jobs:client:notify",
            source,
            "Event emitted! Check the server console."
        )
    end
end, false)
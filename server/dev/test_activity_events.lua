if not Config.DeveloperMode then
    return
end

CreateThread(function()
    Wait(2000)

    OBJobs.Events:On("activity.completed", function(data)
        Logger:Info(("Event heard: activity.completed | %s"):format(
            data.activity:GetLabel()
        ))
    end)

    Logger:Debug("Activity completed listener registered.")
end)
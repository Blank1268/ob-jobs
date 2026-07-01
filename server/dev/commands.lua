if not Config.DeveloperMode then
    return
end

RegisterCommand("objobs", function(source)
    Logger:Info("Registered Jobs:")

    for id, job in pairs(OBJobs.Jobs:GetAll()) do
        Logger:Info(("- %s (%s)"):format(job:GetLabel(), id))
    end
end, false)

RegisterCommand("obactivities", function(source)
    Logger:Info("Registered Activities:")

    for id, activity in pairs(OBJobs.Activities:GetAll()) do
        Logger:Info(("- %s (%s) | Job: %s"):format(
            activity:GetLabel(),
            id,
            activity:GetJob()
        ))
    end
end, false)

RegisterCommand("obnotify", function(source)
    if source == 0 then
        Logger:Warn("Use /obnotify in-game.")
        return
    end

    TriggerClientEvent("ob_jobs:client:notify", source, "OB Jobs custom notification test.")

    Logger:Info(("Sent custom notification test to source %s"):format(source))
end, false)

RegisterCommand("obplayer", function(source)
    if source == 0 then
        Logger:Warn("Use /obplayer in-game.")
        return
    end

    local player = OBJobs.Players:Get(source)

    if not player then
        Logger:Warn(("No OBJobs player registered for source %s"):format(source))
        return
    end

    Logger:Info(("Player Source: %s"):format(player:GetSource()))
    Logger:Info(("Citizen ID: %s"):format(player:GetCitizenId() or "unknown"))
    Logger:Info(("State: %s"):format(player:GetState()))
    Logger:Info(("Current Job: %s"):format(player:GetCurrentJob() or "none"))
    Logger:Info(("On Duty: %s"):format(tostring(player:IsOnDuty())))
end, false)
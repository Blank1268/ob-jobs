if not Config.DeveloperMode then
    return
end

RegisterCommand("obregister", function(source)
    if source == 0 then
        Logger:Warn("Use /obregister in-game.")
        return
    end

    local citizenId = OBJobs.Framework:GetCitizenId(source)

    if not citizenId then
        Logger:Warn(("Could not get citizen ID for source %s"):format(source))
        return
    end

    local player = OBJobs.Players:Register(source, citizenId)

    player:SetCurrentJob("construction")
    player:SetDuty(true)

    TriggerClientEvent("ob_jobs:client:notify", source, "OB player registered and set on duty.")

    Logger:Info(("Registered player %s | CitizenID: %s"):format(source, citizenId))
end, false)
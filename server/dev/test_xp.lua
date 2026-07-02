if not Config.DeveloperMode then
    return
end

RegisterCommand("obxp", function(source, args)
    if source == 0 then
        Logger:Warn("Use /obxp in-game.")
        return
    end

    local amount = tonumber(args[1]) or 50
    local jobId = args[2] or "construction"

    local player = OBJobs.Players:Get(source)

    if not player then
        local citizenId = OBJobs.Framework:GetCitizenId(source)

        if not citizenId then
            Logger:Warn("Could not get citizen ID.")
            return
        end

        player = OBJobs.Players:Register(source, citizenId)
    end

    local result = OBJobs.XP:Add(player, jobId, amount)
    local progress = OBJobs.XP:GetProgress(player, jobId)

    TriggerClientEvent("ob_jobs:client:notify", source, ("+%s XP in %s | Level %s | %s%%"):format(
        result.xpGained or 0,
        jobId,
        progress.level,
        progress.progress
    ))

    if result.leveledUp then
        TriggerClientEvent("ob_jobs:client:notify", source, ("Level Up! %s is now level %s"):format(
            jobId,
            result.currentLevel
        ))
    end

    Logger:Info(("XP Test: source %s gained %s XP in %s. Level: %s"):format(
        source,
        result.xpGained or 0,
        jobId,
        progress.level
    ))
end, false)
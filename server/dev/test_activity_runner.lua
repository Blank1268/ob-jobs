if not Config.DeveloperMode then
    return
end

RegisterCommand("obtestactivity", function(source)
    if source == 0 then
        Logger:Warn("This command must be used in-game.")
        return
    end

    local citizenId = OBJobs.Framework:GetCitizenId(source)

    if not citizenId then
        Logger:Warn("Could not find citizen ID.")
        return
    end

    local player = OBJobs.Players:Get(source)

    if not player then
        player = OBJobs.Players:Register(source, citizenId)
    end

    player:SetCurrentJob("construction")
    player:SetDuty(true)

    OBJobs.Activities:Start(player, "dig_foundation")
end, false)
if not Config.DeveloperMode then
    return
end

CreateThread(function()
    Wait(2500)

    OBJobs.Contracts:Register({
        id = "residential_foundation",
        job = "construction",
        label = "Residential Foundation",
        description = "Prepare and dig out a residential foundation.",
        activities = {
            "dig_foundation"
        },
        reward = 100,
        xp = 25,
        requiredLevel = 1,
        requiredTool = "hands"
    })

    Logger:Debug("Test contract registered.")
end)

RegisterCommand("obcontract", function(source)
    if source == 0 then
        Logger:Warn("Use /obcontract in-game.")
        return
    end

    local player = OBJobs.Players:Get(source)

    if not player then
        local citizenId = OBJobs.Framework:GetCitizenId(source)

        if not citizenId then
            Logger:Warn("Could not get citizen ID.")
            return
        end

        player = OBJobs.Players:Register(source, citizenId)
    end

    player:SetCurrentJob("construction")
    player:SetDuty(true)

    OBJobs.Contracts:Start(player, "residential_foundation")
end, false)
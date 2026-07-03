if not Config.DeveloperMode then
    return
end

CreateThread(function()

    Wait(2000)

    OBJobs.Activities:Register({
        id = "dig_foundation",
        job = "construction",
        label = "Dig Foundation",
        duration = 10,
        reward = 250,
        xp = 50,
        requiredLevel = 1,
        requiredTool = "hands"
    })

    OBJobs.Activities:Register({
        id = "dig_foundation_shovel",
        job = "construction",
        label = "Dig Foundation with Shovel",
        duration = 10,
        reward = 75,
        xp = 35,
        requiredLevel = 1,
        requiredTool = "shovel"
    })

end)

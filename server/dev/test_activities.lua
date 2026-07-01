if not Config.DeveloperMode then
    return
end

CreateThread(function()

    Wait(2000)

    OBJobs.Activities:Register({

        id = "dig_foundation",

        job = "construction",

        label = "Dig Foundation",

        duration = 30,

        reward = 250,

        xp = 50

    })

    OBJobs.Activities:Register({

        id = "repair_pole",

        job = "electrician",

        label = "Repair Power Pole",

        duration = 45,

        reward = 550,

        xp = 125

    })

    local activity = OBJobs.Activities:Get("repair_pole")

    Logger:Debug(("Activity Loaded: %s"):format(activity:GetLabel()))

end)
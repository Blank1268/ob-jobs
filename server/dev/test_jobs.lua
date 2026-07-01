if not Config.DeveloperMode then
    return
end

CreateThread(function()
    Wait(1500)

    Logger:Debug("Loading developer test jobs...")

    OBJobs.Jobs:Register({
        id = "construction",
        label = "Construction",
        icon = "helmet-safety"
    })

    OBJobs.Jobs:Register({
        id = "electrician",
        label = "Electrician",
        icon = "bolt"
    })

    local job = OBJobs.Jobs:Get("construction")

    if job then
        Logger:Debug(("Developer test lookup successful: %s"):format(job:GetLabel()))
    end
end)
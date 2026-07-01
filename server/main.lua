CreateThread(function()
    Wait(1000)

    print(("^2[OB Jobs]^7 Framework v%s Loaded"):format(OBJobs.Version))

    OBJobs.Registry:RegisterJob({
        id = "construction",
        label = "Construction",
        icon = "helmet-safety",
        maxLevel = 100
    })

    OBJobs.Registry:RegisterJob({
        id = "electrician",
        label = "Electrician",
        icon = "bolt",
        maxLevel = 100
    })

    local construction = OBJobs.Registry:GetJob("construction")

    if construction then
        print(("^2[OB Jobs]^7 Test lookup successful: %s"):format(construction.label))
    else
        print("^1[OB Jobs]^7 Test lookup failed")
    end
end)
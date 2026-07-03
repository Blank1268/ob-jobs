local Tasks = {}

function Tasks:Start(data)
    if not data then
        return false, "Missing task data."
    end

    if not data.player then
        return false, "Missing player."
    end

    if not data.label then
        return false, "Missing task label."
    end

    if not data.duration then
        return false, "Missing task duration."
    end

    Logger:Debug(("Starting task '%s'"):format(data.label))

    return OBJobs.Progress:Start(data)
end

OBJobs.Tasks = Tasks
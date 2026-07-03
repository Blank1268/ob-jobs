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

    local source = data.player:GetSource()

    Logger:Debug(("Starting task: %s"):format(data.label))

    if data.animation then
        Logger:Debug("Task received animation data.")
    else
        Logger:Debug("Task received NO animation data.")
    end

    if OBJobs.Animation then
        OBJobs.Animation:Start(source, data.animation)
    end

    return OBJobs.Progress:Start({
        player = data.player,
        label = data.label,
        duration = data.duration,

        onSuccess = function()
            if OBJobs.Animation then
                OBJobs.Animation:Stop(source)
            end

            if data.onSuccess then
                data.onSuccess()
            end
        end
    })
end

OBJobs.Tasks = Tasks
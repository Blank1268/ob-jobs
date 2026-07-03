local Progress = {}

function Progress:Start(data)
    SetTimeout(data.duration, function()
        if data.onSuccess then
            data.onSuccess()
        end
    end)

    return true
end

OBJobs.Progress = Progress
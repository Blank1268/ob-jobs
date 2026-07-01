local Jobs = {}

Jobs.Items = {}

function Jobs:Register(data)
    if type(data) ~= "table" then
        Logger:Error("Jobs:Register failed: data must be a table")
        return false
    end

    if not data.id or data.id == "" then
        Logger:Error("Jobs:Register failed: missing job id")
        return false
    end

    if not data.label or data.label == "" then
        Logger:Error(("Jobs:Register failed for '%s': missing label"):format(data.id))
        return false
    end

    if self.Items[data.id] then
        Logger:Warn(("Job '%s' is already registered, overwriting"):format(data.id))
    end

    local job = Job:new(data)

    self.Items[job:GetId()] = job

    Logger:Info(("Registered job: %s (%s)"):format(job:GetLabel(), job:GetId()))

    return true
end

function Jobs:Get(jobId)
    return self.Items[jobId]
end

function Jobs:Exists(jobId)
    return self.Items[jobId] ~= nil
end

function Jobs:GetAll()
    return self.Items
end

function Jobs:Remove(jobId)
    if not self.Items[jobId] then
        return false
    end

    self.Items[jobId] = nil
    Logger:Info(("Removed job: %s"):format(jobId))

    return true
end

OBJobs.Jobs = Jobs
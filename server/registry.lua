local Registry = {}

Registry.Jobs = {}

function Registry:Register(data)
    if type(data) ~= "table" then
        Logger:Error("Registry:Register failed: data must be a table")
        return false
    end

    if not data.id or data.id == "" then
        Logger:Error("Registry:Register failed: missing job id")
        return false
    end

    if not data.label or data.label == "" then
        Logger:Error(("Registry:Register failed for '%s': missing label"):format(data.id))
        return false
    end

    if self.Jobs[data.id] then
        Logger:Warn(("Job '%s' is already registered, overwriting"):format(data.id))
    end

    local job = Job:new(data)

    self.Jobs[job:GetId()] = job

    Logger:Info(("Registered job: %s (%s)"):format(job:GetLabel(), job:GetId()))

    return true
end

function Registry:Get(jobId)
    return self.Jobs[jobId]
end

function Registry:Exists(jobId)
    return self.Jobs[jobId] ~= nil
end

function Registry:GetAll()
    return self.Jobs
end

function Registry:Remove(jobId)
    if not self.Jobs[jobId] then
        return false
    end

    self.Jobs[jobId] = nil
    Logger:Info(("Removed job: %s"):format(jobId))

    return true
end

OBJobs.Registry = Registry
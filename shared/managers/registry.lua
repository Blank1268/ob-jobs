local Registry = {}

Registry.Jobs = {}

---Registers a new job with the framework.
---@param job table
---@return boolean success
function Registry:RegisterJob(job)
    if type(job) ~= "table" then
        print("^1[OB Jobs]^7 RegisterJob failed: job must be a table")
        return false
    end

    if not job.id or job.id == "" then
        print("^1[OB Jobs]^7 RegisterJob failed: missing job id")
        return false
    end

    if not job.label or job.label == "" then
        print(("^1[OB Jobs]^7 RegisterJob failed for '%s': missing label"):format(job.id))
        return false
    end

    if self.Jobs[job.id] then
        print(("^3[OB Jobs]^7 Job '%s' is already registered, overwriting"):format(job.id))
    end

    job.maxLevel = job.maxLevel or 100
    job.enabled = job.enabled ~= false

    self.Jobs[job.id] = job

    print(("^2[OB Jobs]^7 Registered job: %s (%s)"):format(job.label, job.id))

    return true
end

---Gets a registered job by id.
---@param jobId string
---@return table|nil
function Registry:GetJob(jobId)
    return self.Jobs[jobId]
end

---Checks if a job exists.
---@param jobId string
---@return boolean
function Registry:JobExists(jobId)
    return self.Jobs[jobId] ~= nil
end

---Returns all registered jobs.
---@return table
function Registry:GetJobs()
    return self.Jobs
end

OBJobs.Registry = Registry
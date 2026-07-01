---------------------------------------------------------------------
-- Job Registration
---------------------------------------------------------------------

exports("RegisterJob", function(jobData)
    return OBJobs.Jobs:Register(jobData)
end)

exports("GetJob", function(jobId)
    return OBJobs.Jobs:Get(jobId)
end)

exports("GetJobs", function()
    return OBJobs.Jobs:GetAll()
end)

exports("JobExists", function(jobId)
    return OBJobs.Jobs:Exists(jobId)
end)
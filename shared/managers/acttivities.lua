local Activities = {}

Activities.Items = {}

function Activities:Register(data)

    if not data.id then
        Logger:Error("Activity missing id.")
        return false
    end

    if not data.job then
        Logger:Error(("Activity '%s' missing job."):format(data.id))
        return false
    end

    if not OBJobs.Jobs:Exists(data.job) then
        Logger:Error(("Job '%s' does not exist."):format(data.job))
        return false
    end

    local activity = OBJobs.Classes.Activity:new(data)

    self.Items[activity:GetId()] = activity

    Logger:Info(("Registered Activity: %s"):format(activity:GetLabel()))

    return true

end

function Activities:Get(id)
    return self.Items[id]
end

function Activities:GetAll()
    return self.Items
end

OBJobs.Activities = Activities
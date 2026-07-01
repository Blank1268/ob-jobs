OBJobs.Classes.Activity = {}
OBJobs.Classes.Activity.__index = OBJobs.Classes.Activity

function OBJobs.Classes.Activity:new(data)

    local self = setmetatable({}, OBJobs.Classes.Activity)

    self.id = data.id
    self.job = data.job

    self.label = data.label

    self.duration = data.duration or 30

    self.reward = data.reward or 0

    self.xp = data.xp or 0

    self.cooldown = data.cooldown or 0

    self.enabled = data.enabled ~= false

    return self

end

function OBJobs.Classes.Activity:GetId()
    return self.id
end

function OBJobs.Classes.Activity:GetJob()
    return self.job
end

function OBJobs.Classes.Activity:GetLabel()
    return self.label
end

function OBJobs.Classes.Activity:GetReward()
    return self.reward
end

function OBJobs.Classes.Activity:GetXP()
    return self.xp
end

function OBJobs.Classes.Activity:GetDuration()
    return self.duration
end

function OBJobs.Classes.Activity:IsEnabled()
    return self.enabled
end

function OBJobs.Classes.Activity:CanStart(player)
    if not self:IsEnabled() then
        return false, "Activity is disabled."
    end

    if not player then
        return false, "Invalid player."
    end

    if player:GetState() ~= OBJobs.State.ON_DUTY then
        return false, "Player is not on duty."
    end

    return true
end
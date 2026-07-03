OBJobs.Classes.Activity = {}
OBJobs.Classes.Activity.__index = OBJobs.Classes.Activity

function OBJobs.Classes.Activity:new(data)
    local self = setmetatable({}, OBJobs.Classes.Activity)

    self.id = data.id
    self.job = data.job
    self.label = data.label

    self.requiredLevel = data.requiredLevel or 1
    self.requiredTool = data.requiredTool

    self.duration = data.duration or 30
    self.reward = data.reward or 0
    self.xp = data.xp or 0
    self.cooldown = data.cooldown or 0
    self.enabled = data.enabled ~= false
    self.animation = data.animation

    assert(self.id, "Contract requires an id.")
    assert(self.job, "Contract requires a job.")
    

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

function OBJobs.Classes.Activity:GetRequiredLevel()
    return self.requiredLevel
end

function OBJobs.Classes.Activity:GetRequiredTool()
    return self.requiredTool
end

function OBJobs.Classes.Activity:IsEnabled()
    return self.enabled
end

function OBJobs.Classes.Activity:GetAnimation()
    return self.animation
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

    local requiredLevel = self:GetRequiredLevel()
    local playerLevel = player:GetLevel(self:GetJob())

    if playerLevel < requiredLevel then
        return false, ("Requires %s Level %s"):format(
            self:GetJob(),
            requiredLevel
        )
    end

    local requiredTool = self:GetRequiredTool()

    if requiredTool then
        local hasTool, reason = OBJobs.Tools:Has(player, requiredTool)

        if not hasTool then
            return false, reason
        end
    end

    return true
end
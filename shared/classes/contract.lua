OBJobs.Classes.Contract = {}
OBJobs.Classes.Contract.__index = OBJobs.Classes.Contract

function OBJobs.Classes.Contract:new(data)
    local self = setmetatable({}, OBJobs.Classes.Contract)

    self.id = data.id
    self.job = data.job

    self.label = data.label or "Unnamed Contract"
    self.description = data.description or ""

    self.activities = data.activities or {}

    self.reward = data.reward or 0
    self.xp = data.xp or 0

    self.requiredLevel = data.requiredLevel or 1
    self.requiredTool = data.requiredTool

    self.location = data.location

    self.enabled = data.enabled ~= false

    return self
end

function OBJobs.Classes.Contract:GetId()
    return self.id
end

function OBJobs.Classes.Contract:GetJob()
    return self.job
end

function OBJobs.Classes.Contract:GetLabel()
    return self.label
end

function OBJobs.Classes.Contract:GetDescription()
    return self.description
end

function OBJobs.Classes.Contract:GetActivities()
    return self.activities
end

function OBJobs.Classes.Contract:GetReward()
    return self.reward
end

function OBJobs.Classes.Contract:GetXP()
    return self.xp
end

function OBJobs.Classes.Contract:GetRequiredLevel()
    return self.requiredLevel
end

function OBJobs.Classes.Contract:GetRequiredTool()
    return self.requiredTool
end

function OBJobs.Classes.Contract:GetLocation()
    return self.location
end

function OBJobs.Classes.Contract:IsEnabled()
    return self.enabled
end

function OBJobs.Classes.Contract:GetActivityCount()
    return #self.activities
end
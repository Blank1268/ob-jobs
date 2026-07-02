OBJobs.Classes.Player = {}
OBJobs.Classes.Player.__index = OBJobs.Classes.Player

function OBJobs.Classes.Player:new(source, citizenId)
    local self = setmetatable({}, OBJobs.Classes.Player)

    self.source = source
    self.citizenId = citizenId
    self.state = OBJobs.State.IDLE
    self.currentJob = nil
    self.onDuty = false
    self.jobs = {}
    self.activeActivity = nil
    self.activeContract = nil
    self.session = {}

    return self
end

function OBJobs.Classes.Player:GetSource()
    return self.source
end

function OBJobs.Classes.Player:GetCitizenId()
    return self.citizenId
end

function OBJobs.Classes.Player:GetState()
    return self.state
end

function OBJobs.Classes.Player:SetState(state)
    self.state = state
end

function OBJobs.Classes.Player:SetCurrentJob(jobId)
    self.currentJob = jobId
end

function OBJobs.Classes.Player:GetCurrentJob()
    return self.currentJob
end

function OBJobs.Classes.Player:SetDuty(value)
    self.onDuty = value == true

    if self.onDuty then
        self:SetState(OBJobs.State.ON_DUTY)
    else
        self:SetState(OBJobs.State.IDLE)
    end
end

function OBJobs.Classes.Player:IsOnDuty()
    return self.onDuty
end

function OBJobs.Classes.Player:EnsureJobData(jobId)
    if not self.jobs[jobId] then
        self.jobs[jobId] = {
            level = 1,
            xp = 0,
            reputation = 0
        }
    end

    return self.jobs[jobId]
end

function OBJobs.Classes.Player:GetJobData(jobId)
    return self:EnsureJobData(jobId)
end

function OBJobs.Classes.Player:GetXP(jobId)
    return self:EnsureJobData(jobId).xp
end

function OBJobs.Classes.Player:GetLevel(jobId)
    return self:EnsureJobData(jobId).level
end

function OBJobs.Classes.Player:GetReputation(jobId)
    return self:EnsureJobData(jobId).reputation
end

function OBJobs.Classes.Player:AddReputation(jobId, amount)
    local data = self:EnsureJobData(jobId)
    data.reputation = data.reputation + amount

    return {
        success = true,
        reputation = data.reputation
    }
end
OBJobs.Classes.Player = {}
OBJobs.Classes.Player.__index = OBJobs.Classes.Player

function OBJobs.Classes.Player:new(source, citizenId)

    local self = setmetatable({}, OBJobs.Classes.Player)

    self.source = source
    self.citizenId = citizenId

    self.state = OBJobs.State.IDLE

    self.currentJob = nil

    self.onDuty = false

    self.levels = {}

    self.reputation = {}

    self.activity = nil

    self.contract = nil

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

function OBJobs.Classes.Player:IsOnDuty()
    return self.onDuty
end

function OBJobs.Classes.Player:SetDuty(value)
    self.onDuty = value == true

    if self.onDuty then
        self:SetState(OBJobs.State.ON_DUTY)
    else
        self:SetState(OBJobs.State.IDLE)
    end
end

function OBJobs.Classes.Player:SetCurrentJob(jobId)
    self.currentJob = jobId
end

function OBJobs.Classes.Player:GetCurrentJob()
    return self.currentJob
end
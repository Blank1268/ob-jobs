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
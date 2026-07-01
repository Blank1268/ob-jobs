Job = {}
Job.__index = Job

---Creates a new Job object.
---@param data table
---@return table
function Job:new(data)
    local self = setmetatable({}, Job)

    self.id = data.id
    self.label = data.label
    self.icon = data.icon or "briefcase"
    self.maxLevel = data.maxLevel or Config.DefaultMaxLevel
    self.enabled = data.enabled ~= false

    return self
end

function Job:GetId()
    return self.id
end

function Job:GetLabel()
    return self.label
end

function Job:GetIcon()
    return self.icon
end

function Job:GetMaxLevel()
    return self.maxLevel
end

function Job:IsEnabled()
    return self.enabled
end
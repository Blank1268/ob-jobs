local Contracts = {}

Contracts.Items = {}
Contracts.Active = {}

function Contracts:Register(data)
    if type(data) ~= "table" then
        Logger:Error("Contracts:Register failed: data must be a table")
        return false
    end

    if not data.id then
        Logger:Error("Contract missing id.")
        return false
    end

    if not data.job then
        Logger:Error(("Contract '%s' missing job."):format(data.id))
        return false
    end

    if not OBJobs.Jobs:Exists(data.job) then
        Logger:Error(("Contract '%s' uses unknown job '%s'."):format(data.id, data.job))
        return false
    end

    local contract = OBJobs.Classes.Contract:new(data)

    self.Items[contract:GetId()] = contract

    Logger:Info(("Registered Contract: %s"):format(contract:GetLabel()))

    return true
end

function Contracts:Get(id)
    return self.Items[id]
end

function Contracts:GetAll()
    return self.Items
end

function Contracts:Start(player, contractId)
    local contract = self:Get(contractId)

    if not contract then
        Logger:Error(("Contract '%s' does not exist."):format(contractId))
        return false
    end

    self.Active[player:GetSource()] = {
        contract = contract,
        index = 1,
        state = OBJobs.ContractState.ACTIVE
    }

    player.activeContract = contract:GetId()

    Logger:Info(("[%s] started contract: %s"):format(
        player:GetSource(),
        contract:GetLabel()
    ))

    TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("Started contract: %s"):format(
        contract:GetLabel()
    ))

    self:StartCurrentActivity(player)

    return true
end

function Contracts:GetActive(player)
    return self.Active[player:GetSource()]
end

function Contracts:Complete(player)
    local active = self:GetActive(player)

    if not active then
        return false
    end

    active.state = OBJobs.ContractState.COMPLETED
    player.activeContract = nil

    Logger:Info(("[%s] completed contract: %s"):format(
        player:GetSource(),
        active.contract:GetLabel()
    ))

    TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("Completed contract: %s"):format(
        active.contract:GetLabel()
    ))

    OBJobs.Events:Emit("contract.completed", {
        player = player,
        contract = active.contract,
        timestamp = os.time()
    })

    self.Active[player:GetSource()] = nil

    return true
end

OBJobs.Contracts = Contracts

function Contracts:HandleActivityCompleted(data)
    if not data then return false end
    if not data.player then return false end
    if not data.activity then return false end

    local player = data.player
    local active = self:GetActive(player)

    if not active then
        return false
    end

    local activities = active.contract:GetActivities()
    local currentActivityId = activities[active.index]

    if currentActivityId ~= data.activity:GetId() then
        return false
    end

    active.index = active.index + 1

    if active.index > #activities then
        return self:Complete(player)
    end

    return self:StartCurrentActivity(player)
end

function Contracts:StartCurrentActivity(player)
    local active = self:GetActive(player)

    if not active then
        Logger:Warn("No active contract found.")
        return false
    end

    local activities = active.contract:GetActivities()
    local activityId = activities[active.index]

    if not activityId then
        return self:Complete(player)
    end

    Logger:Info(("[%s] starting contract activity %s/%s: %s"):format(
        player:GetSource(),
        active.index,
        #activities,
        activityId
    ))

    return OBJobs.Activities:Start(player, activityId)
end
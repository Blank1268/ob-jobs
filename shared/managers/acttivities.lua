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

function Activities:Start(player, activityId)
    Logger:Debug("Activities:Start called.")

    local activity = self:Get(activityId)

    if not activity then
        Logger:Error(("Activity '%s' does not exist."):format(activityId))
        return false
    end

    Logger:Debug(("Found activity: %s"):format(activity:GetLabel()))

    local canStart, reason = activity:CanStart(player)

    if not canStart then
        Logger:Warn(("Could not start activity '%s': %s"):format(activityId, reason))
        return false
    end

    Logger:Debug("Activity passed CanStart check.")

    player:SetState(OBJobs.State.DOING_ACTIVITY)

    Logger:Info(("[%s] started activity: %s"):format(
        player:GetSource(),
        activity:GetLabel()
    ))

    local duration = tonumber(activity:GetDuration()) or 5

    Logger:Debug(("Starting %s second timer..."):format(duration))

    local playerSource = player:GetSource()
local duration = tonumber(activity:GetDuration()) or 5

Logger:Debug(("Starting %s second timer for source %s..."):format(duration, playerSource))

SetTimeout(duration * 1000, function()
    Logger:Debug(("Timer finished for source %s."):format(playerSource))
    self:Complete(playerSource, activity)
end)

    return true
end

function Activities:Complete(playerSource, activity)
    Logger:Info(("[%s] completed activity: %s | Reward: $%s | XP: %s"):format(
        playerSource,
        activity:GetLabel(),
        activity:GetReward(),
        activity:GetXP()
    ))

    TriggerClientEvent("QBCore:Notify", tonumber(playerSource), ("Completed: %s | Earned $%s | %s XP"):format(
    activity:GetLabel(),
    activity:GetReward(),
    activity:GetXP()
), "success", 5000)

    local player = OBJobs.Players:Get(playerSource)

    if player then
        player:SetState(OBJobs.State.ON_DUTY)
    end

    return true
end


OBJobs.Activities = Activities
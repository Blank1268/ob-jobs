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
    local activity = self:Get(activityId)

    if not activity then
        Logger:Error(("Activity '%s' does not exist."):format(activityId))
        return false
    end

    local canStart, reason = activity:CanStart(player)

    if not canStart then
        Logger:Warn(("Could not start activity '%s': %s"):format(activityId, reason))
        return false
    end

    local playerSource = player:GetSource()

    player:SetState(OBJobs.State.DOING_ACTIVITY)

    Logger:Info(("[%s] started activity: %s"):format(
        playerSource,
        activity:GetLabel()
    ))

    TriggerClientEvent("ob_jobs:client:notify", playerSource, ("Started activity: %s"):format(
        activity:GetLabel()
    ))

    return OBJobs.Tasks:Start({
        player = player,
        label = activity:GetLabel(),
        duration = activity:GetDuration() * 1000,
        animation = activity:GetAnimation(),

        onSuccess = function()
            self:Complete(playerSource, activity)
        end
    })
end

function Activities:Complete(playerSource, activity)
    Logger:Info(("[%s] completed activity: %s | Reward: $%s | XP: %s"):format(
        playerSource,
        activity:GetLabel(),
        activity:GetReward(),
        activity:GetXP()
    ))

    OBJobs.Events:Emit("activity.completed", {
        playerSource = playerSource,
        player = OBJobs.Players:Get(playerSource),
        activity = activity,
        timestamp = os.time()
    })

    TriggerClientEvent("ob_jobs:client:notify", playerSource, ("Completed: %s"):format(
        activity:GetLabel()
    ))

    local player = OBJobs.Players:Get(playerSource)

    if player then
        player:SetState(OBJobs.State.ON_DUTY)
    end

    return true
end

OBJobs.Activities = Activities
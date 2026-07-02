OBJobs.Modules = OBJobs.Modules or {}

local Rewards = {}

function Rewards:Initialize()
    OBJobs.Events:On("activity.completed", function(data)
        self:HandleActivityCompleted(data)
    end)

    Logger:Info("Reward Module Loaded")
end

function Rewards:HandleActivityCompleted(data)
    if not data then return end
    if not data.player then return end
    if not data.activity then return end

    local player = data.player
    local activity = data.activity
    local amount = tonumber(activity:GetReward()) or 0

    if amount <= 0 then
        return
    end

    local qbPlayer = OBJobs.Framework:GetPlayer(player:GetSource())

    if not qbPlayer then
        Logger:Warn(("Could not pay reward. QBCore player missing for source %s"):format(player:GetSource()))
        return
    end

    qbPlayer.Functions.AddMoney("cash", amount, "ob-jobs-activity-reward")

    TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("+$%s earned from %s"):format(
        amount,
        activity:GetLabel()
    ))

    Logger:Info(("Paid $%s to source %s for %s"):format(
        amount,
        player:GetSource(),
        activity:GetLabel()
    ))

    OBJobs.Events:Emit("reward.paid", {
        player = player,
        activity = activity,
        amount = amount,
        type = "cash",
        timestamp = os.time()
    })
end

OBJobs.Modules.Rewards = Rewards
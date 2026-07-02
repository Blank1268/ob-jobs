OBJobs.Modules = OBJobs.Modules or {}

local Progression = {}

function Progression:Initialize()
    OBJobs.Events:On("activity.completed", function(data)
        self:HandleActivityCompleted(data)
    end)

    Logger:Info("Progression Module Loaded")
end

function Progression:HandleActivityCompleted(data)
    if not data then return end
    if not data.player then return end
    if not data.activity then return end

    local player = data.player
    local activity = data.activity

    local result = OBJobs.XP:Add(
        player,
        activity:GetJob(),
        activity:GetXP()
    )

    if not result.success then
        Logger:Warn(("XP award failed: %s"):format(result.error or "unknown error"))
        return
    end

    TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("+%s XP in %s"):format(
        result.xpGained,
        activity:GetJob()
    ))

    if result.leveledUp then
        TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("Level Up! %s is now level %s"):format(
            activity:GetJob(),
            result.currentLevel
        ))

        OBJobs.Events:Emit("player.levelup", {
            player = player,
            jobId = activity:GetJob(),
            previousLevel = result.previousLevel,
            currentLevel = result.currentLevel,
            timestamp = os.time()
        })
    end
end

OBJobs.Modules.Progression = Progression
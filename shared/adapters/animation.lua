local Animation = {}

function Animation:Start(playerSource, animation)
    if not animation then
        return true
    end

    TriggerClientEvent("ob_jobs:client:startAnimation", playerSource, animation)

    return true
end

function Animation:Stop(playerSource)
    TriggerClientEvent("ob_jobs:client:stopAnimation", playerSource)
end

OBJobs.Animation = Animation
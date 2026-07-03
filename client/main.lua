RegisterNetEvent("ob_jobs:client:notify", function(message)
    print("[OB Jobs Client Notify] " .. tostring(message))

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(tostring(message))
    EndTextCommandThefeedPostTicker(false, true)
end)

RegisterNetEvent("ob_jobs:client:startAnimation", function(animation)
    print("[OB Jobs] startAnimation event received")

    if not animation then
        print("[OB Jobs] No animation data received.")
        return
    end

    local ped = PlayerPedId()

    if animation.scenario then
        print("[OB Jobs] Playing scenario: " .. animation.scenario)

        ClearPedTasksImmediately(ped)
        TaskStartScenarioInPlace(ped, animation.scenario, 0, true)
        return
    end
end)

RegisterNetEvent("ob_jobs:client:stopAnimation", function()
    ClearPedTasks(PlayerPedId())
end)
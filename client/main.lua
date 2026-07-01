RegisterNetEvent("ob_jobs:client:notify", function(message)
    print("[OB Jobs Client Notify] " .. tostring(message))

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(tostring(message))
    EndTextCommandThefeedPostTicker(false, true)
end)
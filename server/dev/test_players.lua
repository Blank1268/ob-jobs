if not Config.DeveloperMode then
    return
end

AddEventHandler("playerJoining", function(source)
    local qbPlayer = exports["qb-core"]:GetCoreObject().Functions.GetPlayer(source)

    if not qbPlayer then
        Logger:Warn("Could not get QBCore player during join.")
        return
    end

    local player = OBJobs.Players:Register(
        source,
        qbPlayer.PlayerData.citizenid
    )

    Logger:Debug(("Player object created for %s"):format(player.citizenId))
end)

AddEventHandler("playerDropped", function()
    OBJobs.Players:Remove(source)
end)
OBJobs.Framework = {}

local QBCore = exports['qb-core']:GetCoreObject()

function OBJobs.Framework:GetCore()
    return QBCore
end

function OBJobs.Framework:GetPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function OBJobs.Framework:GetCitizenId(source)
    local player = self:GetPlayer(source)

    if not player then
        return nil
    end

    return player.PlayerData.citizenid
end

function OBJobs.Framework:GetName(source)
    local player = self:GetPlayer(source)

    if not player then
        return nil
    end

    return ("%s %s"):format(
        player.PlayerData.charinfo.firstname,
        player.PlayerData.charinfo.lastname
    )
end
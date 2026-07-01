local Players = {}

Players.Items = {}

function Players:Register(source, citizenId)
    if self.Items[source] then
        Logger:Warn(("Player %s is already registered."):format(source))
        return self.Items[source]
    end

    local player = OBJobs.Classes.Player:new(source, citizenId)

    self.Items[source] = player

    Logger:Debug(("Registered player [%s]"):format(source))

    return player
end

function Players:Get(source)
    return self.Items[source]
end

function Players:Exists(source)
    return self.Items[source] ~= nil
end

function Players:Remove(source)
    if not self.Items[source] then
        return false
    end

    self.Items[source] = nil

    Logger:Debug(("Removed player [%s]"):format(source))

    return true
end

function Players:GetAll()
    return self.Items
end

OBJobs.Players = Players
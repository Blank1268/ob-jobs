Logger:Debug("xp.lua service loaded")

local XP = {}

function XP:GetXPForLevel(level)
    level = tonumber(level) or 1

    if level <= 20 then
        return level * 100
    end

    if level <= 50 then
        return 2000 + ((level - 20) * 175)
    end

    return 7250 + ((level - 50) * 300)
end

function XP:GetLevelFromXP(totalXP)
    local level = 1
    local maxLevel = Config.Progression.MaxLevel

    while level < maxLevel do
        local requiredXP = self:GetXPForLevel(level)

        if totalXP < requiredXP then
            break
        end

        level = level + 1
    end

    return level
end

function XP:Add(player, jobId, amount)
    amount = tonumber(amount) or 0

    if not player then
        return { success = false, error = "Invalid player." }
    end

    if not jobId then
        return { success = false, error = "Missing job id." }
    end

    if amount <= 0 then
        return { success = false, error = "XP amount must be positive." }
    end

    local data = player:EnsureJobData(jobId)

    local previousLevel = data.level
    local previousXP = data.xp

    data.xp = data.xp + math.floor(amount * Config.Progression.XP.BaseMultiplier)
    data.level = self:GetLevelFromXP(data.xp)

    local leveledUp = data.level > previousLevel

    return {
        success = true,
        job = jobId,
        previousLevel = previousLevel,
        currentLevel = data.level,
        previousXP = previousXP,
        totalXP = data.xp,
        xpGained = data.xp - previousXP,
        leveledUp = leveledUp
    }
end

function XP:GetXP(player, jobId)
    if not player then return 0 end
    return player:GetXP(jobId)
end

function XP:GetLevel(player, jobId)
    if not player then return 1 end
    return player:GetLevel(jobId)
end

function XP:GetProgress(player, jobId)
    if not player then
        return {
            level = 1,
            xp = 0,
            currentLevelXP = 0,
            nextLevelXP = self:GetXPForLevel(1),
            progress = 0
        }
    end

    local data = player:EnsureJobData(jobId)
    local level = data.level
    local xp = data.xp

    local currentLevelXP = level <= 1 and 0 or self:GetXPForLevel(level - 1)
    local nextLevelXP = self:GetXPForLevel(level)

    local needed = nextLevelXP - currentLevelXP
    local gained = xp - currentLevelXP

    local progress = 0

    if needed > 0 then
        progress = math.floor((gained / needed) * 100)
    end

    return {
        level = level,
        xp = xp,
        currentLevelXP = currentLevelXP,
        nextLevelXP = nextLevelXP,
        progress = progress
    }
end

function XP:GetJobSlots(player)
    if not player then return 1 end

    local highestLevel = 1

    for _, data in pairs(player.jobs or {}) do
        if data.level > highestLevel then
            highestLevel = data.level
        end
    end

    local slots = 1

    for level, amount in pairs(Config.Progression.JobSlots) do
        if highestLevel >= level and amount > slots then
            slots = amount
        end
    end

    return slots
end

OBJobs.XP = XP
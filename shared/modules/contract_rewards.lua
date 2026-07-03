OBJobs.Modules = OBJobs.Modules or {}

Logger:Debug("contract_rewards.lua loaded")

local ContractRewards = {}

function ContractRewards:Initialize()
    OBJobs.Events:On("contract.completed", function(data)
        self:HandleContractCompleted(data)
    end)

    Logger:Debug("Contract reward listener registered.")

    Logger:Info("Contract Reward Module Loaded")
end

function ContractRewards:HandleContractCompleted(data)
    Logger:Debug("ContractRewards:HandleContractCompleted called.")
    if not data then return end
    if not data.player then return end
    if not data.contract then return end

    local player = data.player
    local contract = data.contract

    local reward = tonumber(contract:GetReward()) or 0
    local xp = tonumber(contract:GetXP()) or 0

    if reward > 0 then
        local qbPlayer = OBJobs.Framework:GetPlayer(player:GetSource())

        if qbPlayer then
            qbPlayer.Functions.AddMoney("cash", reward, "ob-jobs-contract-bonus")

            TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("Contract bonus: +$%s"):format(reward))
        end
    end

    if xp > 0 then
        local result = OBJobs.XP:Add(player, contract:GetJob(), xp)

        if result.success then
            TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("Contract XP bonus: +%s XP"):format(result.xpGained))

            if result.leveledUp then
                TriggerClientEvent("ob_jobs:client:notify", player:GetSource(), ("Level Up! %s is now level %s"):format(
                    contract:GetJob(),
                    result.currentLevel
                ))
            end
        end
    end
end

OBJobs.Modules.ContractRewards = ContractRewards
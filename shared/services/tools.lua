local Tools = {}

function Tools:Get(toolId)
    if not toolId then
        return nil
    end

    return Config.Tools.Items[toolId]
end

function Tools:Exists(toolId)
    return self:Get(toolId) ~= nil
end

function Tools:Has(player, toolId)
    if not player then
        return false, "Invalid player."
    end

    local tool = self:Get(toolId)

    if not tool then
        return false, ("Unknown tool '%s'."):format(toolId)
    end

    if tool.item == nil then
        return true, nil
    end

    local qbPlayer = OBJobs.Framework:GetPlayer(player:GetSource())

    if not qbPlayer then
        return false, "QBCore player not found."
    end

    local item = qbPlayer.Functions.GetItemByName(tool.item)

    if not item then
        return false, ("Missing required tool: %s"):format(tool.label)
    end

    return true, nil
end

OBJobs.Tools = Tools
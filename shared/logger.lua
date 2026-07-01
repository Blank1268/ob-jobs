Logger = {}

local PREFIX = "^5[OB Jobs]^7 "

function Logger:Info(message)
    print(PREFIX .. "^2" .. message)
end

function Logger:Warn(message)
    print(PREFIX .. "^3" .. message)
end

function Logger:Error(message)
    print(PREFIX .. "^1" .. message)
end

function Logger:Debug(message)
    if Config.Debug then
        print(PREFIX .. "^6[DEBUG]^7 " .. message)
    end
end
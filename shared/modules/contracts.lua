OBJobs.Modules = OBJobs.Modules or {}

local ContractModule = {}

function ContractModule:Initialize()
    OBJobs.Events:On("activity.completed", function(data)
        OBJobs.Contracts:HandleActivityCompleted(data)
    end)

    Logger:Info("Contract Module Loaded")
end

OBJobs.Modules.Contracts = ContractModule
OBJobs.Core = {}

OBJobs.Core.Initialized = false

---Initializes the framework.
function OBJobs.Core:Initialize()
    if self.Initialized then
        Logger:Warn("Framework already initialized.")
        return
    end

    Logger:Info("Initializing OB Jobs Framework...")

    if OBJobs.Core.Validator then
        OBJobs.Core.Validator:Run()
    end
    
    if OBJobs.Modules and OBJobs.Modules.Progression then
        OBJobs.Modules.Progression:Initialize()
    end

    if OBJobs.Modules and OBJobs.Modules.Rewards then
        OBJobs.Modules.Rewards:Initialize()
    end

    self.Initialized = true

    Logger:Info("Framework Ready.")
end

if OBJobs.Modules and OBJobs.Modules.Contracts then
    OBJobs.Modules.Contracts:Initialize()
end
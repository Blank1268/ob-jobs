OBJobs.Core = {}

OBJobs.Core.Initialized = false

---Initializes the framework.
function OBJobs.Core:Initialize()

    if self.Initialized then
        Logger:Warn("Framework already initialized.")
        return
    end

    Logger:Info("Initializing OB Jobs Framework...")

    self.Initialized = true

    Logger:Info("Framework Ready.")

end
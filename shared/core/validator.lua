OBJobs.Core.Validator = {}

function OBJobs.Core.Validator:Check(name, value)
    if value then
        Logger:Info(("✓ %s Loaded"):format(name))
        return true
    end

    Logger:Error(("✗ %s Missing"):format(name))
    return false
end

function OBJobs.Core.Validator:Run()
    Logger:Info("Running startup validation...")

    self:Check("Config", Config)
    self:Check("Logger", Logger)
    self:Check("Framework Adapter", OBJobs.Framework)
    self:Check("Jobs Manager", OBJobs.Jobs and OBJobs.Jobs.Register)
    self:Check("Activities Manager", OBJobs.Activities and OBJobs.Activities.Register)
    self:Check("Players Manager", OBJobs.Players and OBJobs.Players.Register)
    self:Check("XP Service", OBJobs.XP and OBJobs.XP.Add)

    Logger:Info("Startup validation complete.")
end
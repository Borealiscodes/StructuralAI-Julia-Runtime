module Config

export Config, load_config

"""
    Config

Runtime configuration container.
Fields will expand as execution logic is implemented.
"""
struct Config
    threshold_path::String
    model_path::String
    telemetry_mode::Symbol
end

"""
    load_config(; threshold_path="thresholds.json",
                 model_path="model.json",
                 telemetry_mode=:CAUSA_LGT)

Placeholder for configuration loading.
Will later parse files or command-line arguments.
"""
function load_config(; threshold_path="thresholds.json",
                      model_path="model.json",
                      telemetry_mode=:CAUSA_LGT)

    return Config(threshold_path, model_path, telemetry_mode)
end

end # module

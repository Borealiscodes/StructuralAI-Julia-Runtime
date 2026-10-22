module ModelInterface

export ModelHandle,
       load_model,
       run_model_step

"""
    ModelHandle

Abstract container for a model instance.
This allows the runtime to remain backend-agnostic.
"""
struct ModelHandle
    backend::Symbol   # e.g., :transformer, :diffusion, :custom
    model::Any        # TODO: replace with concrete model type
end

"""
    load_model(config)

Load a model according to the provided configuration.
This is scaffolding only — backend-specific loading logic will be added later.
"""
function load_model(config)
    # TODO: inspect config
    # TODO: initialize backend-specific model
    # TODO: return ModelHandle
    error("load_model not yet implemented")
end

"""
    run_model_step(handle, input)

Run a single model step and return raw telemetry.
This is scaffolding only — execution and telemetry extraction will be added later.
"""
function run_model_step(handle::ModelHandle, input)
    # TODO: execute model step
    # TODO: extract raw telemetry (CAUSA + LGT)
    # TODO: return raw telemetry packet
    error("run_model_step not yet implemented")
end

end # module

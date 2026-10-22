module Pipeline

using ..Runtime.Telemetry
using ..Operators.Curvature
using ..Operators.Spectral
using ..Operators.Holonomy
using ..Operators.Topology
using ..Operators.Fusion
using ..Stability.StabilityState
using ..Stability.Thresholds
using ..LeanBridge.Export
using ..Runtime.Config

export run_pipeline

"""
    run_pipeline(model, raw_telemetry; config=load_config())

Execution-ready runtime pipeline.

This function defines the full data flow for a single step:
1. Ingest raw telemetry
2. Normalize telemetry
3. Execute all operators
4. Apply thresholds
5. Assemble stability state
6. Export stability state (placeholder)

Notes:
- No operator math is implemented yet.
- No real model stepping is implemented yet.
- Lean export is a placeholder until Schema + Export are finalized.
"""
function run_pipeline(model, raw_telemetry; config=load_config())

    ### 1. Ingest raw telemetry
    packet = ingest_telemetry(raw_telemetry)

    ### 2. Normalize telemetry
    normed = normalize_telemetry(packet)

    ### 3. Execute operators (placeholder math)
    vals = (
        curvature = compute_curvature(normed),
        spectral  = compute_spectral(normed),
        holonomy  = compute_holonomy(normed),
        topology  = compute_topology(normed),
        fusion    = compute_fusion(normed)
    )

    ### 4. Load thresholds
    thresholds = load_thresholds(config.threshold_path)

    ### 5. Apply thresholds (placeholder logic)
    stable_flags = apply_thresholds(vals, thresholds)

    ### 6. Assemble stability state
    state = StabilityState(
        stable_flags.curvStable,
        stable_flags.specStable,
        stable_flags.holStable,
        stable_flags.topStable,
        stable_flags.fusStable
    )

    ### 7. Export to Lean (placeholder)
    # export_state(state)  # will be implemented later

    return state
end

end # module

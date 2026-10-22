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

Full runtime pipeline with real operator math and stability evaluation.

Steps:
1. Ingest raw telemetry
2. Normalize telemetry
3. Execute operators (real math)
4. Load thresholds
5. Apply thresholds (real comparisons)
6. Assemble stability state
7. Export stability (placeholder)

Returns:
    StabilityState
"""
function run_pipeline(model, raw_telemetry; config=load_config())

    ### 1. Ingest raw telemetry
    packet = ingest_telemetry(raw_telemetry)

    ### 2. Normalize telemetry
    normed = normalize_telemetry(packet)

    ### 3. Execute operators (real math)
    vals = (
        curvature = compute_curvature(normed),
        spectral  = compute_spectral(normed),
        holonomy  = compute_holonomy(normed),
        topology  = compute_topology(normed),
        fusion    = compute_fusion(normed)
    )

    ### 4. Load thresholds
    thresholds = load_thresholds(config.threshold_path)

    ### 5. Apply thresholds (real comparisons)
    stable_flags = apply_thresholds(vals, thresholds)

    ### 6. Assemble stability state
    state = assemble_stability(stable_flags)

    ### 7. Export to Lean (placeholder)
    # export_state(state)

    return state
end

end # module

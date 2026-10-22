module Holonomy

using ..Utils.Types

export compute_holonomy

"""
    compute_holonomy(normed)

Compute a holonomy-deviation proxy using directional activation changes.

This operator uses:
- activation directional differences (proxy for parallel-transport deviation)
- transport misalignment (proxy for connection drift)
- metric scaling (proxy for local manifold distortion)

The result is a Float64 holonomy deviation estimate.

This is a runtime-appropriate holonomy operator: it does not attempt full
parallel transport around loops, which would require full connection access.
"""
function compute_holonomy(normed::NamedTuple)
    act = normed.activation
    met = normed.metric
    trn = normed.transport

    ### 1. Directional activation difference (parallel-transport proxy)
    vals = act.values
    n = length(vals)
    if n < 2
        return 0.0
    end

    # First differences: Δf = f[i+1] - f[i]
    diffs = Float64[]
    for i in 1:n-1
        push!(diffs, vals[i+1] - vals[i])
    end

    # Mean directional change magnitude
    dir_mag = sum(abs.(diffs)) / (n - 1)

    ### 2. Transport misalignment (connection drift proxy)
    # trn.misalignment :: Float64
    mis = trn.misalignment

    ### 3. Metric scaling (local distortion proxy)
    scale = met.scale
    if scale == 0
        scale = 1e-6
    end

    ### 4. Combine into holonomy deviation estimate
    holonomy_value = dir_mag * mis * scale

    return holonomy_value
end

end # module

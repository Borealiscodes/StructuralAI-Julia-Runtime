module Spectral

using ..Utils.Types

export compute_spectral

"""
    compute_spectral(normed)

Compute a spectral-drift proxy using activation variance and metric scaling.

This operator uses:
- activation variance (proxy for eigenvalue spread)
- metric scaling (proxy for local manifold distortion)
- transport weighting (proxy for directional spectral alignment)

The result is a Float64 spectral drift estimate.

This is a runtime-appropriate spectral operator: it does not attempt full
eigenvalue decomposition, which would require full metric tensors and
Jacobian access.
"""
function compute_spectral(normed::NamedTuple)
    act = normed.activation
    met = normed.metric
    trn = normed.transport

    ### 1. Activation variance (eigenvalue spread proxy)
    vals = act.values
    n = length(vals)
    if n == 0
        return 0.0
    end

    μ = sum(vals) / n
    var = sum((v - μ)^2 for v in vals) / n

    ### 2. Metric scaling (local distortion proxy)
    scale = met.scale
    if scale == 0
        scale = 1e-6
    end

    ### 3. Transport weighting (directional spectral alignment)
    weight = trn.weight

    ### 4. Combine into spectral drift estimate
    spectral_value = var * scale * weight

    return spectral_value
end

end # module

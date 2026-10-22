module Curvature

using ..Utils.Types

export compute_curvature

"""
    compute_curvature(normed)

Compute a sectional-curvature proxy using geodesic deviation.

This operator uses:
- activation second differences (proxy for geodesic acceleration)
- metric scaling (proxy for local manifold distortion)
- transport hint weighting (proxy for directional alignment)

The result is a Float64 curvature estimate.

This is the first operator with real math. It remains lightweight and does not
attempt full Riemannian curvature, which would require Christoffel symbols and
geodesic solvers.
"""
function compute_curvature(normed::NamedTuple)
    act = normed.activation
    met = normed.metric
    trn = normed.transport

    ### 1. Activation second difference (geodesic deviation proxy)
    # act.values :: Vector{Float64}
    vals = act.values
    if length(vals) < 3
        return 0.0
    end

    # second difference: Δ² f = f[i+1] - 2f[i] + f[i-1]
    acc = 0.0
    for i in 2:length(vals)-1
        acc += vals[i+1] - 2*vals[i] + vals[i-1]
    end
    acc /= (length(vals) - 2)

    ### 2. Metric scaling (local distortion proxy)
    # met.scale :: Float64
    scale = met.scale
    if scale == 0
        scale = 1e-6
    end

    ### 3. Transport alignment (directional weighting)
    # trn.weight :: Float64
    weight = trn.weight

    ### 4. Combine into curvature estimate
    curvature_value = acc * scale * weight

    return curvature_value
end

end # module

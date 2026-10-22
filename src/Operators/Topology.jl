module Topology

using ..Utils.Types

export compute_topology

"""
    compute_topology(normed)

Compute a topology-collapse proxy using activation compression.

This operator uses:
- activation range (proxy for dimensional collapse)
- metric scale (proxy for manifold degeneracy)
- transport collapse hint (proxy for directional collapse)

The result is a Float64 topology-collapse estimate.

This is a runtime-appropriate topology operator: it does not attempt full
rank or determinant computation, which would require full metric tensors.
"""
function compute_topology(normed::NamedTuple)
    act = normed.activation
    met = normed.metric
    trn = normed.transport

    ### 1. Activation range (dimensional collapse proxy)
    vals = act.values
    n = length(vals)
    if n == 0
        return 0.0
    end

    lo = minimum(vals)
    hi = maximum(vals)
    range = hi - lo

    # Collapse proxy: small range → collapse
    collapse = 1.0 / (range + 1e-6)

    ### 2. Metric scale (manifold degeneracy proxy)
    scale = met.scale
    if scale == 0
        scale = 1e-6
    end

    ### 3. Transport collapse hint (directional collapse proxy)
    # trn.collapse :: Float64
    tc = trn.collapse

    ### 4. Combine into topology-collapse estimate
    topology_value = collapse * scale * tc

    return topology_value
end

end # module

module Fusion

using ..Utils.Types

export compute_fusion

"""
    compute_fusion(normed)

Compute a fusion-field nonlinearity proxy using activation interactions.

This operator uses:
- activation interaction magnitude (proxy for nonlinear coupling)
- metric scale (proxy for manifold modulation)
- transport coupling (proxy for directional interaction strength)

The result is a Float64 fusion-field estimate.

This is a runtime-appropriate fusion operator: it does not attempt full
nonlinear field computation, which would require full tensor access.
"""
function compute_fusion(normed::NamedTuple)
    act = normed.activation
    met = normed.metric
    trn = normed.transport

    ### 1. Activation interaction magnitude (nonlinear coupling proxy)
    vals = act.values
    n = length(vals)
    if n < 2
        return 0.0
    end

    # Interaction proxy: mean absolute pairwise product
    # (captures nonlinear reinforcement or interference)
    inter = 0.0
    count = 0
    for i in 1:n-1
        for j in i+1:n
            inter += abs(vals[i] * vals[j])
            count += 1
        end
    end
    inter /= count

    ### 2. Metric scale (manifold modulation proxy)
    scale = met.scale
    if scale == 0
        scale = 1e-6
    end

    ### 3. Transport coupling (directional interaction proxy)
    # trn.coupling :: Float64
    coup = trn.coupling

    ### 4. Combine into fusion-field estimate
    fusion_value = inter * scale * coup

    return fusion_value
end

end # module

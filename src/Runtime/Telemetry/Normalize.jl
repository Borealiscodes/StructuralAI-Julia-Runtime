module Normalize

using ..Utils.Types

export normalize_telemetry

"""
    normalize_telemetry(packet)

Real telemetry normalization.

Produces:
    ActivationTrace
    MetricEstimate
    TransportHint

Steps:
1. Center activations
2. Scale activations
3. Estimate metric distortion
4. Extract transport hints
5. Smooth structural noise

This is the geometric spine of the runtime.
"""
function normalize_telemetry(packet::NamedTuple)
    raw_vals = packet.values
    n = length(raw_vals)

    ### 1. Center activations
    μ = n == 0 ? 0.0 : sum(raw_vals) / n
    centered = [v - μ for v in raw_vals]

    ### 2. Scale activations (L2 norm)
    norm = sqrt(sum(v^2 for v in centered)) + 1e-6
    scaled = [v / norm for v in centered]

    ### 3. Metric estimation (local distortion proxy)
    # Use variance of centered activations as distortion proxy
    var = n == 0 ? 0.0 : sum((v)^2 for v in centered) / n
    metric_scale = sqrt(var + 1e-6)

    metric = MetricEstimate(metric_scale)

    ### 4. Transport hint extraction
    # Directional alignment: mean absolute first difference
    if n < 2
        dir = 0.0
    else
        diffs = [abs(scaled[i+1] - scaled[i]) for i in 1:n-1]
        dir = sum(diffs) / (n - 1)
    end

    # Misalignment proxy: how much centered activations disagree with scaled ones
    mis = sum(abs(centered[i] - scaled[i]) for i in 1:n) / n

    # Collapse proxy: inverse range of scaled activations
    lo = minimum(scaled)
    hi = maximum(scaled)
    collapse = 1.0 / (hi - lo + 1e-6)

    # Coupling proxy: mean absolute pairwise product of scaled activations
    if n < 2
        coupling = 0.0
    else
        total = 0.0
        count = 0
        for i in 1:n-1
            for j in i+1:n
                total += abs(scaled[i] * scaled[j])
                count += 1
            end
        end
        coupling = total / count
    end

    transport = TransportHint(
        weight = dir,
        misalignment = mis,
        collapse = collapse,
        coupling = coupling
    )

    ### 5. Structural smoothing (simple moving average)
    smoothed = scaled
    if n >= 3
        smoothed = [ (scaled[i-1] + scaled[i] + scaled[i+1]) / 3
                     for i in 2:n-1 ]
        # pad edges
        smoothed = vcat(scaled[1], smoothed, scaled[end])
    end

    activation = ActivationTrace(smoothed)

    return (
        activation = activation,
        metric = metric,
        transport = transport
    )
end

end # module

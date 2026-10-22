module Types

export ActivationTrace,
       MetricEstimate,
       TransportHint

"""
    ActivationTrace

Alias for activation trajectory data.
Exact structure will be refined once telemetry normalization is implemented.
"""
const ActivationTrace = Any   # TODO: replace with concrete type

"""
    MetricEstimate

Alias for metric tensor or metric approximation data.
"""
const MetricEstimate = Any    # TODO: replace with concrete type

"""
    TransportHint

Alias for parallel transport guidance from LGT.
"""
const TransportHint = Any     # TODO: replace with concrete type

end # module

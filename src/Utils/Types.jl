module Types

export ActivationTrace,
       MetricEstimate,
       TransportHint

"""
    ActivationTrace

Container for activation trajectory data extracted from CAUSA.
This is a structural placeholder; fields will be expanded during
telemetry normalization.
"""
struct ActivationTrace
    data::Vector{Float64}   # activation values over time or layers
end

"""
    MetricEstimate

Container for metric tensor or metric approximation data extracted from LGT.
This is a structural placeholder; tensor structure will be refined later.
"""
struct MetricEstimate
    tensor::Matrix{Float64} # metric tensor estimate
end

"""
    TransportHint

Container for parallel transport guidance extracted from LGT.
This is a structural placeholder; direction structure will be refined later.
"""
struct TransportHint
    directions::Vector{Float64} # transport deviation directions
end

end # module

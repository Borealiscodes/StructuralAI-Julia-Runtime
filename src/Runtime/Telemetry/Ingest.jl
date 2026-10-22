module Ingest

using ..Utils.Types

export ingest_telemetry

"""
    ingest_telemetry(raw)

Real telemetry ingestion.

Accepts:
    raw.values :: AbstractVector{<:Real}

Produces:
    NamedTuple:
        values :: Vector{Float64}

Steps:
1. Convert to Float64
2. Clamp pathological values
3. Ensure non-empty vector
4. Provide stable shape for normalization
"""
function ingest_telemetry(raw::NamedTuple)
    raw_vals = raw.values

    ### 1. Convert to Float64
    vals = Float64.(raw_vals)

    ### 2. Clamp pathological values
    # Prevent infinities, NaNs, and absurd magnitudes
    cleaned = Float64[]
    for v in vals
        if isnan(v) || isinf(v)
            push!(cleaned, 0.0)
        else
            push!(cleaned, clamp(v, -1e6, 1e6))
        end
    end

    ### 3. Ensure non-empty vector
    if isempty(cleaned)
        cleaned = [0.0]
    end

    ### 4. Produce stable packet
    return (values = cleaned)
end

end # module

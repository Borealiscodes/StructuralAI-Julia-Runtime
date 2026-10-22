module Spectral

export SpectralResult, compute_spectral_drift

"""
    SpectralResult

Container for spectral drift operator outputs before thresholding.
"""
struct SpectralResult
    value::Float64
    stable::Bool
end

"""
    compute_spectral_drift(telemetry)

Compute the spectral drift operator from telemetry.
This is scaffolding only — eigenvalue drift logic will be added later.
"""
function compute_spectral_drift(telemetry)
    # TODO: extract operator matrices from telemetry
    # TODO: compute eigenvalues at t and t+δ
    # TODO: compute drift norm
    # TODO: return SpectralResult(value, stable)
    error("compute_spectral_drift not yet implemented")
end

end # module

module Thresholds

export CurvatureThresholds,
       SpectralThresholds,
       HolonomyThresholds,
       TopologyThresholds,
       FusionThresholds

export load_thresholds

"""
    CurvatureThresholds

Thresholds for curvature stability evaluation.
"""
struct CurvatureThresholds
    tau_curv::Float64
end

"""
    SpectralThresholds

Thresholds for spectral drift stability evaluation.
"""
struct SpectralThresholds
    tau_spec::Float64
end

"""
    HolonomyThresholds

Thresholds for holonomy deviation stability evaluation.
"""
struct HolonomyThresholds
    tau_hol::Float64
end

"""
    TopologyThresholds

Thresholds for topology collapse stability evaluation.
"""
struct TopologyThresholds
    tau_top::Float64
end

"""
    FusionThresholds

Thresholds for fusion-field nonlinearity stability evaluation.
"""
struct FusionThresholds
    tau_fus::Float64
end

"""
    load_thresholds()

Placeholder for loading threshold values.
Eventually this will pull from config files or runtime parameters.
"""
function load_thresholds()
    # TODO: load thresholds from config or runtime parameters
    error("load_thresholds not yet implemented")
end

end # module

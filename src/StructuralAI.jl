module StructuralAI

# --- Operators ---
include("Operators/Curvature.jl")
include("Operators/Spectral.jl")
include("Operators/Holonomy.jl")
include("Operators/Topology.jl")
include("Operators/Fusion.jl")

# --- Stability ---
include("Stability/StabilityState.jl")
include("Stability/Thresholds.jl")

# --- Runtime ---
include("Runtime/Telemetry.jl")
include("Runtime/ModelInterface.jl")
include("Runtime/Pipeline.jl")

# --- Lean Bridge ---
include("LeanBridge/Export.jl")
include("LeanBridge/Schema.jl")

# --- Utils ---
include("Utils/Types.jl")
include("Utils/MathHelpers.jl")
include("Utils/Logging.jl")

end # module StructuralAI

module StabilityState

export StabilityState, make_state

"""
    StabilityState

Unified stability predicate container for all operators.
Each field corresponds to a Boolean stability predicate.
"""
struct StabilityState
    curvStable::Bool
    specStable::Bool
    holStable::Bool
    topStable::Bool
    fusStable::Bool
end

"""
    make_state(; curvStable, specStable, holStable, topStable, fusStable)

Convenience constructor for building StabilityState objects.
"""
function make_state(; curvStable::Bool,
                      specStable::Bool,
                      holStable::Bool,
                      topStable::Bool,
                      fusStable::Bool)
    StabilityState(curvStable, specStable, holStable, topStable, fusStable)
end

end # module

module StabilityState

export StabilityState, assemble_stability

struct StabilityState
    curvStable::Bool
    specStable::Bool
    holStable::Bool
    topStable::Bool
    fusStable::Bool
end

"""
    assemble_stability(stable_flags)

Convert threshold comparison results into a StabilityState.

Input:
    stable_flags :: NamedTuple
        curvStable
        specStable
        holStable
        topStable
        fusStable

Output:
    StabilityState
"""
function assemble_stability(stable_flags::NamedTuple)
    return StabilityState(
        stable_flags.curvStable,
        stable_flags.specStable,
        stable_flags.holStable,
        stable_flags.topStable,
        stable_flags.fusStable
    )
end

end # module

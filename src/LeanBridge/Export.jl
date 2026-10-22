module Export

import ..Stability.StabilityState: StabilityState

export ExportPacket,
       build_export_packet,
       write_states_json

"""
    ExportPacket

Container for data destined for Lean ingestion.
This mirrors the structure of StabilityState but is decoupled from runtime internals.
"""
struct ExportPacket
    curvStable::Bool
    specStable::Bool
    holStable::Bool
    topStable::Bool
    fusStable::Bool
end

"""
    build_export_packet(state::StabilityState)

Convert a StabilityState into an ExportPacket.
This is scaffolding only — additional metadata may be added later.
"""
function build_export_packet(state::StabilityState)
    ExportPacket(
        state.curvStable,
        state.specStable,
        state.holStable,
        state.topStable,
        state.fusStable
    )
end

"""
    write_states_json(path, packets)

Write a list of ExportPacket objects to a JSON file for Lean ingestion.
This is scaffolding only — JSON serialization will be added later.
"""
function write_states_json(path::String, packets::Vector{ExportPacket})
    # TODO: serialize packets to JSON
    # TODO: write to file at `path`
    error("write_states_json not yet implemented")
end

end # module

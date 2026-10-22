module Schema

export StabilitySchema,
       validate_export_packet

"""
    StabilitySchema

Schema definition for the JSON structure exported to Lean.
This mirrors the fields in ExportPacket and StabilityState.
"""
struct StabilitySchema
    curvStable::Bool
    specStable::Bool
    holStable::Bool
    topStable::Bool
    fusStable::Bool
end

"""
    validate_export_packet(packet)

Validate that an ExportPacket conforms to the StabilitySchema.
This is scaffolding only — real validation logic will be added later.
"""
function validate_export_packet(packet)
    # TODO: check field presence
    # TODO: check field types
    # TODO: check schema consistency
    error("validate_export_packet not yet implemented")
end

end # module

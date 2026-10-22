module Telemetry

using ..Utils.Types

export ingest_telemetry,
       normalize_telemetry

"""
    ingest_telemetry(raw)

Ingest raw telemetry from CAUSA + LGT sources.
This function converts unstructured input into a structured packet
that can be normalized. No numerical processing occurs here.
"""
function ingest_telemetry(raw::Dict)
    # Expected raw keys (scaffolding only)
    act = raw["activation_trace"]
    met = raw["metric_tensor"]
    trn = raw["transport_hint"]

    return (
        activation = act,
        metric     = met,
        transport  = trn
    )
end

"""
    normalize_telemetry(packet)

Convert ingested telemetry into strongly typed containers:
ActivationTrace, MetricEstimate, and TransportHint.

This prepares data for operator execution. Numerical routines
will be added later.
"""
function normalize_telemetry(packet)
    act = ActivationTrace(packet.activation)
    met = MetricEstimate(packet.metric)
    trn = TransportHint(packet.transport)

    return (
        activation = act,
        metric     = met,
        transport  = trn
    )
end

end # module

% FUNCTION: Returns the current time as an ISO 8601 UTC string, e.g. 2026-10-09T18:04:11.532Z
function ts = timestamp_utc()
    ts = string(datetime('now', 'TimeZone', 'UTC', 'Format', 'yyyy-MM-dd''T''HH:mm:ss.SSS')) + "Z";
end

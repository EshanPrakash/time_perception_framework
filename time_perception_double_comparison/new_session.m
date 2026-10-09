% FUNCTION: Creates a unique session ID (UUID) and records the session start time.
function [session_id, session_start] = new_session()
    try
        session_id = string(char(java.util.UUID.randomUUID().toString()));
    catch
        % Fallback if the JVM is unavailable.
        hex = '0123456789abcdef';
        s = hex(randi(16, 1, 32));
        session_id = string(strjoin({s(1:8), s(9:12), s(13:16), s(17:20), s(21:32)}, '-'));
    end
    session_start = timestamp_utc();
end

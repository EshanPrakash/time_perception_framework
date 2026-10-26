% FUNCTION: Builds the description of one stimulus interval, as a struct
% with fields Modality, Audio, Visual (the audio and visual durations in
% seconds, NaN when that modality is absent) and Judged (the duration the
% participant is asked to judge).
%
% modality is "visual", "audio", "both" or "conflict". For "conflict", a
% proportion conflict_proportion of intervals have mismatched audio and
% visual durations: the modality named by judged_modality gets the judged
% duration and the other modality (the distractor) gets the judged duration
% scaled by 1 +/- conflict_ratio, with the sign chosen at random. The other
% intervals are congruent and returned as "both".
function interval = make_interval(duration, modality, judged_modality, conflict_ratio, conflict_proportion)
    interval.Judged = duration;
    interval.Modality = modality;
    if modality == "visual"
        interval.Audio = NaN;
        interval.Visual = duration;
    elseif modality == "audio"
        interval.Audio = duration;
        interval.Visual = NaN;
    elseif modality == "both"
        interval.Audio = duration;
        interval.Visual = duration;
    elseif modality == "conflict"
        if conflict_ratio < 0 || conflict_ratio >= 1
            error('conflict_ratio must be at least 0 and less than 1.');
        end
        if judged_modality ~= "audio" && judged_modality ~= "visual"
            error('Unknown judged modality: %s', judged_modality);
        end
        if rand() < conflict_proportion
            distractor = duration * (1 + conflict_ratio * (2 * (rand() < 0.5) - 1));
            if judged_modality == "audio"
                interval.Audio = duration;
                interval.Visual = distractor;
            else
                interval.Audio = distractor;
                interval.Visual = duration;
            end
        else
            interval.Modality = "both";
            interval.Audio = duration;
            interval.Visual = duration;
        end
    else
        error('Unknown stimulus modality: %s', modality);
    end
end

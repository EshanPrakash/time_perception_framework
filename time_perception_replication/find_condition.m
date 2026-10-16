% FUNCTION: Function to find the stimulus and duration to present for a
% given trial indicator number. Condition numbers run over every
% (stimulus, duration) pair.
function [image, duration] = find_condition(stimulus_type, durations, number)
        [image_index, duration_index] = ind2sub([length(stimulus_type), length(durations)], number);
        image = stimulus_type(image_index);
        duration = durations(duration_index);
end

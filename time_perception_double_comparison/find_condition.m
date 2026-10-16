% FUNCTION: Function to find the stimulus, standard duration, and
% comparison duration to present an image for, given a trial indicator
% number. Condition numbers run over every (standard, comparison) pair:
% twoimage_comp_durations has one row per standard duration and one column
% per comparison duration.
function [stimulus, standard_duration, comp_duration] = find_condition(number, stimulus, twoimage_comp_durations, twoimage_standard_durations)
    [std_duration_index, comp_duration_index] = ind2sub(size(twoimage_comp_durations), number);
    standard_duration = twoimage_standard_durations(std_duration_index);
    comp_duration = twoimage_comp_durations(std_duration_index, comp_duration_index);
end

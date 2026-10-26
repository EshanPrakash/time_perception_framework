% FUNCTION: function to present the standard image before experimental and
% training trials.
function present_std_image(directory_link, stimulus, standard_duration, window, background_color, black, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency)
    display_screen_text('The standard duration will now be presented. \n The durations in the next few trials should be compared to this standard. \n Press the spacebar to continue.', ...
            window, ...
            background_color, ...
            black, ...
            screenXpixels);
    WaitSecs(0.5);

    % The standard is always congruent, even in conflict experiments.
    if stimulus_modality == "conflict"
        stimulus_modality = "both";
    end
    interval = make_interval(standard_duration, stimulus_modality, "audio", 0, 0);

    texture = [];
    if stimulus_modality ~= "audio"
        texture = make_stimulus_texture(window, directory_link, stimulus, screenYpixels);
    end
    % The standard is always presented without the debug fixation cross.
    present_stimulus(window, texture, interval, background_color, black, screenXpixels, pahandle, audio_frequency, false);
    if ~isempty(texture)
        Screen('Close', texture);
    end
    WaitSecs(0.5);

    display_screen_text('In the trials to follow, please compare the durations in each trial with the length of the standard. \n \n Press the spacebar to begin the trials.', ...
            window, ...
            background_color, ...
            black, ...
            screenXpixels);
end

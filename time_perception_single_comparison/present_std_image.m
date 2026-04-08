% FUNCTION: function to present the standard image before experimental and
% training trials.
function present_std_image(directory_link, stimulus, standard_duration, window, background_color, black, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency)
    display_screen_text('The standard duration will now be presented. \n The durations in the next few trials should be compared to this standard. \n Press the spacebar to continue.', ...
            window, ...
            background_color, ...
            black, ...
            screenXpixels);
    WaitSecs(0.5);

    if stimulus_modality == "visual"
        if stimulus == "default"
            stimulus_link = directory_link + stimulus + ".jpg";
        else
            stimulus_link = directory_link + stimulus;
        end
        texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));
        Screen('DrawTexture', window, texture, [], [], 0);
        Screen('Flip', window);
        WaitSecs(standard_duration);
        Screen('FillRect', window, background_color);
        Screen('Flip', window);
    else
        audiodata = MakeBeep(audio_frequency, standard_duration, 44100);
        PsychPortAudio('FillBuffer', pahandle, audiodata);
        Screen('FillRect', window, background_color);
        Screen('Flip', window);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        WaitSecs(standard_duration);
        PsychPortAudio('Stop', pahandle);
        Screen('FillRect', window, background_color);
        Screen('Flip', window);
    end
    WaitSecs(0.5);

    display_screen_text('In the trials to follow, please compare the durations in each trial with the length of the standard. \n \n Press the spacebar to begin the trials.', ...
            window, ...
            background_color, ...
            black, ...
            screenXpixels);
end

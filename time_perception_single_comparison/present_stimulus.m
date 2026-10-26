% FUNCTION: Presents a single stimulus interval. interval is the struct
% built by make_interval, with fields Modality, Audio and Visual.
% Modality is "visual", "audio", "both" or "conflict". For "both"
% (congruent presentation) the image and the tone start together and last
% for the same duration. For "conflict" they have different durations and
% the shorter one is centred in the longer one, with an equal gap at the
% beginning and end. texture is ignored for "audio".
function present_stimulus(window, texture, interval, back_color, black, screenXpixels, pahandle, audio_frequency, debug_mode)
    modality = interval.Modality;
    % Length of the whole interval (max ignores the NaN of an absent modality)
    duration = max(interval.Audio, interval.Visual);
    if modality ~= "visual"
        PsychPortAudio('FillBuffer', pahandle, MakeBeep(audio_frequency, interval.Audio, 44100));
    end

    if modality == "visual"
        Screen('FillRect', window, back_color);
        Screen('DrawTexture', window, texture, [], [], 0);
        Screen('Flip', window);
        WaitSecs(duration);
    elseif modality == "audio"
        if debug_mode
            Screen('TextSize', window, round(screenXpixels/40));
            Screen('TextFont', window, 'Arial');
            DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
        else
            Screen('FillRect', window, back_color);
        end
        Screen('Flip', window);
        PsychPortAudio('Start', pahandle, 1, 0, 1);
        WaitSecs(duration);
        PsychPortAudio('Stop', pahandle);
    elseif modality == "both"
        % Schedule the tone and the screen flip for the same moment. The
        % flip lands on the first screen refresh after that time, so the
        % two onsets can differ by up to one refresh interval.
        start_time = GetSecs() + 0.1;
        Screen('FillRect', window, back_color);
        Screen('DrawTexture', window, texture, [], [], 0);
        PsychPortAudio('Start', pahandle, 1, start_time, 0);
        Screen('Flip', window, start_time);
        WaitSecs(duration);
        PsychPortAudio('Stop', pahandle);
    elseif modality == "conflict"
        % The interval starts at start_time and lasts for the longer of the
        % two stimuli. The shorter stimulus starts half the difference
        % later, so it ends the same amount of time before the end.
        start_time = GetSecs() + 0.1;
        audio_start = start_time + (duration - interval.Audio) / 2;
        visual_start = start_time + (duration - interval.Visual) / 2;
        PsychPortAudio('Start', pahandle, 1, audio_start, 0);
        Screen('FillRect', window, back_color);
        Screen('DrawTexture', window, texture, [], [], 0);
        Screen('Flip', window, visual_start);
        Screen('FillRect', window, back_color);
        Screen('Flip', window, visual_start + interval.Visual);
        WaitSecs('UntilTime', start_time + duration);
        PsychPortAudio('Stop', pahandle);
    else
        error('Unknown stimulus modality: %s', modality);
    end

    Screen('FillRect', window, back_color);
    Screen('Flip', window);
end

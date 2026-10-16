% FUNCTION: Presents a single stimulus interval of the given duration.
% modality is "visual", "audio", or "both". For "both" (congruent
% presentation) the image and the tone are scheduled to start together
% and last for the same duration. texture is ignored for "audio".
function present_stimulus(window, texture, duration, modality, back_color, black, screenXpixels, pahandle, audio_frequency, debug_mode)
    if modality ~= "visual"
        PsychPortAudio('FillBuffer', pahandle, MakeBeep(audio_frequency, duration, 44100));
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
    else
        error('Unknown stimulus modality: %s', modality);
    end

    Screen('FillRect', window, back_color);
    Screen('Flip', window);
end

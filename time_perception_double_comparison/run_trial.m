% FUNCTION: Function to run each trial.
function [response] = run_trial(stimulus, standard_duration, comp_duration, comp_order, comp_type, back_color, black, directory_link, window, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency, debug_mode)

if comp_order == "random"
    order = randperm(2);
    if order(1) == 1
        duration1 = standard_duration;
        duration2 = comp_duration;
    else
        duration1 = comp_duration;
        duration2 = standard_duration;
    end
else
    duration1 = standard_duration;
    duration2 = comp_duration;
end

% Fixation cross before first stimulus
Screen('FillRect', window, back_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
Screen('Flip', window);
WaitSecs(1);

if stimulus_modality == "visual"
    stimulus_link = directory_link + stimulus;
    texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));

    % First stimulus
    Screen('DrawTexture', window, texture, [], [], 0);
    Screen('Flip', window);
    WaitSecs(duration1);

    % Fixation cross between stimuli
    Screen('FillRect', window, back_color);
    Screen('Flip', window);
    Screen('TextSize', window, round(screenXpixels/40));
    Screen('TextFont', window, 'Arial');
    DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
    Screen('Flip', window);
    WaitSecs(1);

    % Second stimulus
    Screen('DrawTexture', window, texture, [], [], 0);
    Screen('Flip', window);
    WaitSecs(duration2);
    Screen('FillRect', window, back_color);
    Screen('Flip', window);
else
    % First audio stimulus
    audiodata1 = MakeBeep(audio_frequency, duration1, 44100);
    PsychPortAudio('FillBuffer', pahandle, audiodata1);
    if debug_mode
        Screen('TextSize', window, round(screenXpixels/40));
        Screen('TextFont', window, 'Arial');
        DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
    else
        Screen('FillRect', window, back_color);
    end
    Screen('Flip', window);
    PsychPortAudio('Start', pahandle, 1, 0, 1);
    WaitSecs(duration1);
    PsychPortAudio('Stop', pahandle);

    % Fixation cross between stimuli
    Screen('FillRect', window, back_color);
    Screen('Flip', window);
    Screen('TextSize', window, round(screenXpixels/40));
    Screen('TextFont', window, 'Arial');
    DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
    Screen('Flip', window);
    WaitSecs(1);

    % Second audio stimulus
    audiodata2 = MakeBeep(audio_frequency, duration2, 44100);
    PsychPortAudio('FillBuffer', pahandle, audiodata2);
    if debug_mode
        Screen('TextSize', window, round(screenXpixels/40));
        Screen('TextFont', window, 'Arial');
        DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
    else
        Screen('FillRect', window, back_color);
    end
    Screen('Flip', window);
    PsychPortAudio('Start', pahandle, 1, 0, 1);
    WaitSecs(duration2);
    PsychPortAudio('Stop', pahandle);
    Screen('FillRect', window, back_color);
    Screen('Flip', window);
end

% Response signal
Screen('FillRect', window, back_color);
Screen('Flip', window);

response = collect_comparison_response(comp_type);
% Switching response order if presentation was random
if response == "shorter" && duration1 == comp_duration
    response = "longer";
elseif response == "longer" && duration1 == comp_duration
    response = "shorter";

WaitSecs(1);
end

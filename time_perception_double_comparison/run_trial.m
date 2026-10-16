% FUNCTION: Function to run each trial.
function [response] = run_trial(stimulus, standard_duration, comp_duration, comp_order, comp_type, back_color, black, directory_link, window, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency, debug_mode)

if comp_order == "random"
    order = randperm(2);
    comp_first = (order(1) == 2);
    if order(1) == 1
        duration1 = standard_duration;
        duration2 = comp_duration;
    else
        duration1 = comp_duration;
        duration2 = standard_duration;
    end
else
    comp_first = false;
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

texture = [];
if stimulus_modality ~= "audio"
    texture = make_stimulus_texture(window, directory_link, stimulus, screenYpixels);
end

% First stimulus
present_stimulus(window, texture, duration1, stimulus_modality, back_color, black, screenXpixels, pahandle, audio_frequency, debug_mode);

% Fixation cross between stimuli
Screen('FillRect', window, back_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
Screen('Flip', window);
WaitSecs(1);

% Second stimulus
present_stimulus(window, texture, duration2, stimulus_modality, back_color, black, screenXpixels, pahandle, audio_frequency, debug_mode);
if ~isempty(texture)
    Screen('Close', texture);
end

% Response signal
Screen('FillRect', window, back_color);
Screen('Flip', window);

response = collect_comparison_response(comp_type);
% Switching response order if the comparison was presented first, so that
% responses are always coded relative to the comparison duration.
if comp_first
    if response == "shorter"
        response = "longer";
    elseif response == "longer"
        response = "shorter";
    end
end
WaitSecs(1);
end

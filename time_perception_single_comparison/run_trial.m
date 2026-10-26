% FUNCTION: Function to run each trial.
function response = run_trial(directory_link, stimulus, interval, comp_type, window, back_color, black, screenXpixels, screenYpixels, pahandle, audio_frequency, debug_mode)

texture = [];
if interval.Modality ~= "audio"
    texture = make_stimulus_texture(window, directory_link, stimulus, screenYpixels);
end
present_stimulus(window, texture, interval, back_color, black, screenXpixels, pahandle, audio_frequency, debug_mode);
if ~isempty(texture)
    Screen('Close', texture);
end
WaitSecs(0.5);

% Response signal
WaitSecs(0.5);
Screen('FillRect', window, back_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);
Screen('Flip', window);

response = collect_comparison_response(comp_type);
WaitSecs(0.5);
end

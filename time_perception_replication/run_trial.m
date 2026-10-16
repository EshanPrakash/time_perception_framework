% FUNCTION: Function to run each trial. 
function [stimulus, duration, response] = run_trial(stimulus, duration, response_type, background_color, black, ...
    directory_link, window, screenYpixels, screenXpixels, stimulus_modality, pahandle, audio_frequency, debug_mode)

texture = [];
if stimulus_modality ~= "audio"
    texture = make_stimulus_texture(window, directory_link, stimulus, screenYpixels);
end
present_stimulus(window, texture, duration, stimulus_modality, background_color, black, screenXpixels, pahandle, audio_frequency, debug_mode);
if ~isempty(texture)
    Screen('Close', texture);
end
WaitSecs(0.5);

% Response signal
Screen('FillRect', window, background_color);
Screen('Flip', window);
Screen('TextSize', window, round(screenXpixels/40));
Screen('TextFont', window, 'Arial');
DrawFormattedText(window, '+', 'center', 'center', 0, round(screenXpixels*(1/20)), black);   
Screen('Flip', window);
response = collect_replication_response(response_type);
Screen('FillRect', window, background_color);
Screen('Flip', window);
WaitSecs(1);
end
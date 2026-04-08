% FUNCTION: Function to display centered text on the screen. An input parameter
% (text) is a string that specifies which text will be displayed.
function success = display_screen_text(text, window, grey, black, screen_size_x)
    success = true;
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    WaitSecs(0.2);  

    Screen('TextSize', window, round(screen_size_x/45));
    Screen('TextFont', window, 'Arial');
    DrawFormattedText(window, text, 'center', 'center', 0, round(screen_size_x*(1/25)), black);
    Screen('Flip', window);

    keylist = zeros(1, 256);
    keylist([KbName('ESCAPE'), KbName('space')]) = 1;
    KbQueueCreate(6, keylist);
    KbQueueStart(6); 
    [~, first_press, ~, ~, ~] = KbQueueCheck(6);
    while first_press == 0 
        [~, first_press, ~, ~, ~] = KbQueueCheck(6); 
    end

    if KbName(first_press) == "ESCAPE"
        success = false;
        Screen('FillRect', window, grey);
        Screen('Flip', window);
        WaitSecs(0.5);
        DrawFormattedText(window, 'Please call the proctor into the room to complete the experiment. You will receive an email shortly about compensation for your participation. \n \n Thank you for participating!', 'center', 'center', 0, round(screen_size_x*(1/25)), black);
        Screen('Flip', window);
        keylist = zeros(1, 256);
        keylist([KbName('ESCAPE'), KbName('space')]) = 1;
        KbQueueCreate(6, keylist);
        KbQueueStart(6); 
        [~, first_press, ~, ~, ~] = KbQueueCheck(6);
        while first_press == 0 
            [~, first_press, ~, ~, ~] = KbQueueCheck(6); 
        end
        sca;
        return  
    end
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    WaitSecs(0.5); 
end

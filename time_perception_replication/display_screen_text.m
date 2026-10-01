% FUNCTION: Function to display centered text on the screen. An input parameter
% (text) is a string that specifies which text will be displayed.
function success = display_screen_text(text, window, grey, black, screenXpixels)
    success = true;
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    WaitSecs(0.2);  

    Screen('TextSize', window, round(screenXpixels/45));
    Screen('TextFont', window, 'Arial');
    DrawFormattedText(window, text, 'center', 'center', 0, round(screenXpixels*(1/25)), black);
    Screen('Flip', window);

    if ispc
        kb_device = -3;
    else
        kb_device = [];
    end
    keylist = zeros(1, 256);
    keylist([KbName('ESCAPE'), KbName('space')]) = 1;
    KbQueueCreate(kb_device, keylist);
    KbQueueStart(kb_device);
    [~, first_press, ~, ~, ~] = KbQueueCheck(kb_device);
    while first_press == 0
        [~, first_press, ~, ~, ~] = KbQueueCheck(kb_device);
    end

    if KbName(first_press) == "ESCAPE"
        success = false;
        Screen('FillRect', window, grey);
        Screen('Flip', window);
        WaitSecs(0.5);
        DrawFormattedText(window, 'Please call the proctor into the room to complete the experiment. You will receive an email shortly about compensation for your participation. \n \n Thank you for participating!', 'center', 'center', 0, round(screenXpixels*(1/25)), black);
        Screen('Flip', window);
        first_press = 0;
        while first_press == 0
            [~, first_press, ~, ~, ~] = KbQueueCheck(kb_device);
        end
        KbQueueRelease(kb_device);
        sca;
        return  
    end
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    WaitSecs(0.5); 
end

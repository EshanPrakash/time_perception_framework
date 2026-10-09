% FUNCTION: Function to run the single comparison experiment. 
function results = run_singlecomp_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, stimulus, standard_duration, ...
    comp_durations, num_comp_trials, comp_type, stimulus_modality, pahandle, audio_frequency, debug_mode, ...
    white, grey, black, window, screenXpixels, screenYpixels)
    
    [est_time, num_trials, results, exp_condition_list, train_condition_list, break_times] = setup_task(comp_durations, num_comp_trials, num_training_trials, num_breaks);
    [session_id, session_start] = new_session();

    if background_color == "grey"
        back_color = grey;
    else
        back_color = white;
    end
    
    success = display_screen_text('Thank you for your interest in participating in this experiment. \n \n Press the spacebar to continue.', ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    success = display_screen_text('You will begin with several practice trials to get used to the task. You can press the escape key at any time to exit the experiment. \n \n Press the spacebar to continue.', ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    statement = 'In the task, you will be asked how the durations of images presented on each trial compare to a standard image. \n \n Press the spacebar to continue.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end
    
    statement = 'The duration of the standard image will be presented before the training trials begin, and again before the experimental trials begin. \n \n Press the spacebar to continue.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end
    
    statement = 'In each trial, an image will be presented, then a black "plus" will appear on the screen. \n \n Press the spacebar to continue.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end
    
    if comp_type == "shorter/longer"
        statement = 'Once the black plus appears, press the 1 key if the image presented felt shorter in duration than the standard image or press the 2 key if the image presented felt longer than the standard image. \n \n Press the spacebar to continue.';
    elseif comp_type == "equal/not equal"
        statement = 'Once the black plus appears, press the 1 key if the image presented felt like it was presented for the same duration as the standard image. Press 2 otherwise. \n \n Press the spacebar to continue.';
    else 
        statement = 'Once the black plus appears, press the 1 key if the image presented felt shorter in duration than the standard image. \n Press 2 if the image presented feels like it was presented for the same duration as the standard image. Press 3 if the image presented felt longer than the standard image. \n \n Press the spacebar to continue.';
    end 
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    % Presenting standard image for single image comparison experiment. 
    present_std_image(directory_link, stimulus, standard_duration, window, back_color, black, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency);
    WaitSecs(0.5);

    % Run training trials
    for trial_counter=1:length(train_condition_list)
        condition_num = train_condition_list(trial_counter);
        result = run_trial(directory_link, stimulus, comp_durations(condition_num), comp_type, window, back_color, black, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency, debug_mode);
        if result == "escape"
            return
        end
    end

    % Segway into the experiment.
    success = display_screen_text('You have completed the training segment. \n \n Press the spacebar to continue.', ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end
    success = display_screen_text('There will be several breaks built into the experiment session. If you have any questions, please call the proctor into the room.   \n \n Press the spacebar to continue. ', ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end
    success = display_screen_text('Press the spacebar to begin.', ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    % Presenting standard image for single image comparison experiment. 
    present_std_image(directory_link, stimulus, standard_duration, window, back_color, black, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency);
    WaitSecs(0.5);

    % Run experiment. Breaks Included When Necessary
    break_statement = 'You may now take a break. \n \n Press the spacebar to continue the session.';
    for trial_counter=1:length(exp_condition_list)
        % Running trial
        condition_num = exp_condition_list(trial_counter);
        result = run_trial(directory_link, stimulus, comp_durations(condition_num), comp_type, window, back_color, black, screenXpixels, screenYpixels, stimulus_modality, pahandle, audio_frequency, debug_mode);
        if result == "escape"
            save_results(results, trial_counter-1, directory_link, participant_number, session_id, session_start);
            return
        end
        results.Stimulus(trial_counter) = stimulus;
        results.Time_Condition(trial_counter) = comp_durations(condition_num);
        results.Response(trial_counter) = result;
        results.Trial_Datetime(trial_counter) = timestamp_utc();
        if mod(trial_counter, save_after) == 0
            save_results(results, trial_counter, directory_link, participant_number, session_id, session_start);
        end
        % Checking to present break
        if any(break_times == trial_counter)
            success = display_screen_text(break_statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
            if success == false
                save_results(results, trial_counter, directory_link, participant_number, session_id, session_start);
                return
            end
        end
    end
    
    % Saving data table
    save_results(results, num_trials, directory_link, participant_number, session_id, session_start);
        
    % Experiment outro
    end_statement = 'You have completed the experiment! \n \n Call the proctor into the room.';
    success = display_screen_text(end_statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    % Press the spacebar to continue and exit the experiment screen. 
    % End experiment. Exit screen.
    sca;
end
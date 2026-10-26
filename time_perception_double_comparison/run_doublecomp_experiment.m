% FUNCTION: Function to run the double comparison experiment. 
function results = run_doublecomp_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, stimulus, twoimage_standard_durations, ...
    twoimage_comp_durations, num_comp_trials, comp_type, comp_order, stimulus_modality, pahandle, audio_frequency, debug_mode, judged_modality, conflict_ratio, conflict_proportion, ...
    white, grey, black, window, screenXpixels, screenYpixels)

    [est_time, num_trials, results, exp_condition_list, train_condition_list, break_times] = setup_task(twoimage_comp_durations, num_comp_trials, num_training_trials, num_breaks);
    [session_id, session_start] = new_session();

    if background_color == "grey"
        back_color = grey;
    else
        back_color = white;
    end

    % Experiment Intro 
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

    % Task specific instructions 
    statement = 'In the task, you will be presented with two images, one after the other. \n \n Press the spacebar to continue.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    statement = 'After both images are presented, a black "plus" will appear on the screen. \n \n Press the spacebar to continue';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    statement = 'Once the black plus appears, you will make a judgement about how long the second image was on screen relative to the first image. \n \n Press the spacebar to continue.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end
    
    if comp_type == "shorter/longer"
        statement = 'Press the 1 key if the first image presented felt longer in duration. \n Press the 2 key if the second image presented felt longer in duration. \n \n Press the spacebar to continue.';
    elseif comp_type == "equal/not equal"
        statement = 'Press the 1 key if the second image presented felt like it was presented for the same duration as the first image. \n Press 2 otherwise. \n \n Press the spacebar to continue.';
    else 
        statement = 'Press the 1 key if the first image presented felt longer in duration. \n Press 2 if both images felt like they were presented for the same duration. \n Press 3 if the second image presented felt longer than the first image. \n \n Press the spacebar to continue.';
    end 
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    statement = 'Please do not count the durations of the images to compare them. You can press the "escape" button at any time to end the experiment. \n \n Press the spacebar to continue';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    statement = 'Please ask the proctor if you have any questions. \n \n Press the spacebar to continue.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    statement = 'The training segment will begin when you press the spacebar. \n \n Press the spacebar to begin.';
    success = display_screen_text(statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
    if success == false
            return
    end

    % Run training trials
    for trial_counter=1:length(train_condition_list)
        condition_num = train_condition_list(trial_counter);
        [stimulus, standard_duration, comp_duration] = find_condition(condition_num, stimulus, twoimage_comp_durations, twoimage_standard_durations);
        std_interval = make_interval(standard_duration, stimulus_modality, judged_modality, conflict_ratio, conflict_proportion);
        comp_interval = make_interval(comp_duration, stimulus_modality, judged_modality, conflict_ratio, conflict_proportion);
        response = run_trial(stimulus, std_interval, comp_interval, comp_order, comp_type, back_color, black, directory_link, window, screenXpixels, screenYpixels, pahandle, audio_frequency, debug_mode);
        if response == "escape"
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

    
    % Run experiment. Breaks Included When Necessary
    break_statement = 'You may now take a break. \n \n Press the spacebar to continue the session.';
    for trial_counter=1:num_trials
        condition_num = exp_condition_list(trial_counter);
        [stimulus, standard_duration, comp_duration] = find_condition(condition_num, stimulus, twoimage_comp_durations, twoimage_standard_durations);
        std_interval = make_interval(standard_duration, stimulus_modality, judged_modality, conflict_ratio, conflict_proportion);
        comp_interval = make_interval(comp_duration, stimulus_modality, judged_modality, conflict_ratio, conflict_proportion);
        result = run_trial(stimulus, std_interval, comp_interval, comp_order, comp_type, back_color, black, directory_link, window, screenXpixels, screenYpixels, pahandle, audio_frequency, debug_mode);
        if result == "escape"
            save_results(results, trial_counter-1, directory_link, participant_number, session_id, session_start);
            return
        end
        results.Stimulus(trial_counter) = stimulus;
        results.Standard_Time_Condition(trial_counter) = standard_duration;
        results.Comp_Time_Condition(trial_counter) = comp_duration;
        results.Modality(trial_counter) = stimulus_modality;
        results.Standard_Audio_Duration(trial_counter) = std_interval.Audio;
        results.Standard_Visual_Duration(trial_counter) = std_interval.Visual;
        results.Comp_Audio_Duration(trial_counter) = comp_interval.Audio;
        results.Comp_Visual_Duration(trial_counter) = comp_interval.Visual;
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

    % End experiment. Exit screen.
    sca;
end
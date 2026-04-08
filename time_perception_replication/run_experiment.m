% FUNCTION: Function to run the replication experiment. 
function results = run_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, replication_type, stimulus_type, durations, ...
    num_trials, stimulus_modality, pahandle, audio_frequency, debug_mode, white, grey, black, window, screenXpixels, screenYpixels)
    
    [est_time, num_trials, results, exp_condition_list, train_condition_list, break_times] = setup_task(stimulus_type, durations, num_trials, num_training_trials, num_breaks);

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

    % Task specific instructions 
    run_experiment_intro(replication_type, window, back_color, black, screenXpixels);

    % Run training trials
    for trial_counter=1:length(train_condition_list)
        condition_num = train_condition_list(trial_counter);
        [stimulus, duration] = find_condition(stimulus_type, durations, condition_num);
        if stimulus_modality == "alternating"
            if mod(trial_counter, 2) == 1
                trial_modality = "visual";
            else
                trial_modality = "audio";
            end
        else
            trial_modality = stimulus_modality;
        end
        [~, ~, response] = run_trial(stimulus, duration, replication_type, back_color, black, directory_link, window, screenYpixels, screenXpixels, trial_modality, pahandle, audio_frequency, debug_mode);
        if string(response) == "escape"
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
    for trial_counter=1:length(exp_condition_list)
        if mod(trial_counter, save_after) == 0                                                                            
            if exist(char(directory_link + "/results" + string("/dataP" + string(participant_number))), 'file')~=0
                delete(char(directory_link + "/results" + string("/dataP" + string(participant_number))));
            end
            writetable(results, char(directory_link + "/results" + string("/dataP" + string(participant_number))))
        end
        condition_num = exp_condition_list(trial_counter);
        [stimulus, duration] = find_condition(stimulus_type, durations, condition_num);
        if stimulus_modality == "alternating"
            if mod(trial_counter, 2) == 1
                trial_modality = "visual";
            else
                trial_modality = "audio";
            end
        else
            trial_modality = stimulus_modality;
        end
        [stimulus, duration, response] = run_trial(stimulus, duration, replication_type, back_color, black, directory_link, window, screenYpixels, screenXpixels, trial_modality, pahandle, audio_frequency, debug_mode);
        if string(response) == "escape"
            return
        end
        results.Image1(trial_counter) = stimulus;
        results.Time_Condition(trial_counter) = duration;
        results.Modality(trial_counter) = trial_modality;
        results.Response(trial_counter) = response;
        if any(break_times == trial_counter)
            success = display_screen_text(break_statement, ...
            window, ...
            back_color, ... 
            black, ...
            screenXpixels);
            if success == false
                return
            end
        end
    end
    
    % Saving data table
    if exist(char(directory_link + "/results" + string("/dataP" + string(participant_number))), 'file')~=0
                delete(char(directory_link + "/results" + string("/dataP" + string(participant_number))));
    end
    writetable(results, char(directory_link + "/results" + string("/dataP" + string(participant_number))))
        

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
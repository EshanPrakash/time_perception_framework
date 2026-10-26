%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 2);
 sca; 
 close all;                       
 clear;   

% General Parameters - to be changed for each operating system and experiment.
directory_link = "";                                      % directory for experiment folders
save_after = 5;                                           % Save data after __ trials.
participant_number = 0;                                   % participant number
background_color = "white";                               % Choices: "white", "grey"
num_breaks = 1;                                           % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;                                  % Number of training trials to include before data collection. 
   
% Parameters Specific to the Time Comparison Task
comp_type = "shorter/longer";                             % How should images be compared?
                                                            % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer".
comp_order = "random";                                    % Comparison Stimulus Presentation Times.
                                                            % Choices: "fixed", "random"
stimulus_modality = "visual";                             % Choices: "visual", "audio", "both", "conflict"
audio_frequency = 440;                                    % Hz — only used if stimulus_modality ~= "visual"
debug_mode = false;                                       % If true and audio, shows fixation cross during tone
judged_modality = "audio";                                % Only used if stimulus_modality = "conflict". Which modality participants judge; the other is the distractor.
conflict_ratio = 0.2;                                     % Only used if stimulus_modality = "conflict". Distractor duration = judged duration x (1 +/- conflict_ratio).
conflict_proportion = 0.5;                                % Only used if stimulus_modality = "conflict". Proportion of trials with mismatched durations; the rest are congruent.
stimulus = "default.jpg";                                 % Preferred stimulus jpg file name, "default.jpg", or "gaussian" for a Gaussian blob. The image to be used to represent standard and comparison durations.
twoimage_standard_durations = [1, 2, 3];                  % Durations for standard images.
twoimage_comp_durations = [0.5, 0.75, 0.9, 1.1, 1.25, 1.5; ...   % Comparison durations for each standard: one row per standard duration above,
                           1.0, 1.5, 1.8, 2.2, 2.5, 3.0; ...     % in the same order, and one column per comparison duration (6 per standard).
                           1.5, 2.25, 2.7, 3.3, 3.75, 4.5];
num_comp_trials = 10;                                     % How many trials to run for each standard/comparison duration


% Experiment Setup - do not change
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
grey = white / 1.5;
black = BlackIndex(screenNumber);
[window, ~] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
 
% Audio setup
if stimulus_modality ~= "visual"
    InitializePsychSound(1);
    pahandle = PsychPortAudio('Open', [], 1, 1, 44100, 1);
else
    pahandle = [];
end

% Running experiment
data_table = run_doublecomp_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, stimulus, twoimage_standard_durations, ...
    twoimage_comp_durations, num_comp_trials, comp_type, comp_order, stimulus_modality, pahandle, audio_frequency, debug_mode, judged_modality, conflict_ratio, conflict_proportion, ...
    white, grey, black, window, screenXpixels, screenYpixels);

if stimulus_modality ~= "visual"
    PsychPortAudio('Close', pahandle);
end

sca; % Closing screen

%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 2);
 sca; 
 close all;                       
 clear;

% General Parameters - to be changed for each operating system and experiment.
directory_link = "";                % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 0;             % Participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 1;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 


% Parameters Specific to the Time Reproduction Task
replication_type = "hold";          % Choices: "start_stop", "hold", "stop"
stimulus_modality = "alternating";       % Choices: "visual", "audio", "both", "conflict", "alternating"
audio_frequency = 440;              % Hz — only used if stimulus_modality == "audio"
debug_mode = true;                 % If true and audio, shows fixation cross during tone
judged_modality = "audio";               % Only used if stimulus_modality = "conflict". Which modality participants judge; the other is the distractor.
conflict_ratio = 0.2;                    % Only used if stimulus_modality = "conflict". Distractor duration = judged duration x (1 +/- conflict_ratio).
conflict_proportion = 0.5;               % Only used if stimulus_modality = "conflict". Proportion of trials with mismatched durations; the rest are congruent.
stimulus_type = "default.jpg";      % Choices: "default.jpg", "gaussian" (Gaussian blob), ["image path #1", "image path #2, ...].
durations = [1,2,3];                % Durations to test per stimulus. Assumes same  durations for each stimulus.
num_trials = 10;                    % How many trials per duration-stimulus combination.


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
if stimulus_modality ~= "visual"
    InitializePsychSound(1);
    pahandle = PsychPortAudio('Open', [], 1, 1, 44100, 1);
else
    pahandle = [];
end

% Running experiment
data_table = run_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, replication_type, stimulus_type, durations, ...
    num_trials, stimulus_modality, pahandle, audio_frequency, debug_mode, judged_modality, conflict_ratio, conflict_proportion, white, grey, black, window, screenXpixels, screenYpixels);

if stimulus_modality ~= "visual"
    PsychPortAudio('Close', pahandle);
end
sca; % Closing screen

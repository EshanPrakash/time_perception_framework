%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
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
stimulus_modality = "alternating";       % Choices: "visual", "audio", "alternating"
audio_frequency = 440;              % Hz — only used if stimulus_modality == "audio"
debug_mode = true;                 % If true and audio, shows fixation cross during tone
stimulus_type = "default.jpg";      % Choices: "default", ["image path #1", "image path #2, ...].
durations = [1,2];                  % Durations to test per stimulus. Assumes same  durations for each stimulus.
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
if stimulus_modality == "audio" || stimulus_modality == "alternating"
    InitializePsychSound(1);
    pahandle = PsychPortAudio('Open', [], 1, 1, 44100, 1);
else
    pahandle = [];
end

% Running experiment
data_table = run_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, replication_type, stimulus_type, durations, ...
    num_trials, stimulus_modality, pahandle, audio_frequency, debug_mode, white, grey, black, window, screenXpixels, screenYpixels);

if stimulus_modality == "audio" || stimulus_modality == "alternating"
    PsychPortAudio('Close', pahandle);
end
sca; % Closing screen

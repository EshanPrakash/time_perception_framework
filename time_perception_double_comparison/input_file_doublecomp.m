%DON'T CHANGE THIS: Screen Set Up for Running Psychtoolbox
 KbName('UnifyKeyNames');
 Screen('Preference', 'SkipSyncTests', 1);
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
stimulus_modality = "visual";                             % Choices: "visual", "audio"
audio_frequency = 440;                                    % Hz — only used if stimulus_modality == "audio"
debug_mode = false;                                       % If true and audio, shows fixation cross during tone
stimulus = "default.jpg";                                 % Preferred stimulus jpg file name or "default.jpg". The image to be used to represent standard and comparison durations.
twoimage_standard_durations = [1, 2];                     % Durations for standard images. Each duration will be used for each standard image.
twoimage_comp_durations = [0.5, 1, 1.5; 1.5, 2, 2.5];     % What comparison durations should be used relative to each standard duration? List in order of standard durations indicated above.
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
if stimulus_modality == "audio"
    InitializePsychSound(1);
    pahandle = PsychPortAudio('Open', [], 1, 1, 44100, 1);
else
    pahandle = [];
end

% Running experiment
data_table = run_doublecomp_experiment(directory_link, save_after, participant_number, ...
    background_color, num_breaks, num_training_trials, stimulus, twoimage_standard_durations, ...
    twoimage_comp_durations, num_comp_trials, comp_type, comp_order, stimulus_modality, pahandle, audio_frequency, debug_mode, ...
    white, grey, black, window, screenXpixels, screenYpixels);

if stimulus_modality == "audio"
    PsychPortAudio('Close', pahandle);
end

sca; % Closing screen

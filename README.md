# A User Friendly Approach to Measuring Short Duration Time Perception
Included is a body of MATLAB code designed for running time perception experiments using [Psychtoolbox 3.0.19.16 "Last Free Dessert"]([http://psychtoolbox.org/download](https://github.com/Psychtoolbox-3/Psychtoolbox-3/releases)) on [MATLAB 2024B](https://www.mathworks.com/products/new_products/latest_features.html) accompanying the article, A User-Friendly Approach to Measuring Short Duration Time Perception, published on PsychArXiv on August 24, 2025. This version of Psychtoolbox is open access and free to use on any device, while MATLAB can be accessed via a subscription by most universities and organizations. Sample analysis code is provided in [R 4.4.2 "Pile of Leaves"](https://cran.r-project.org/bin/windows/base/), an open access programming language and platform. No packages or other dependencies are required.

# About This Fork
This fork extends the original framework with audio stimulus support, enabling experiments to present intervals as tones in addition to (or alternating with) visual stimuli. The goal is to make the framework more flexible for multi-modal time perception research.

# What kinds of experiments can I run using this code?
This code supports visual and auditory prospective time replication and comparison experiments. The following structure is used for all experiments: Insert diagram. 

- Introduction
- Task explanations and introductions
- Training Trials
- Experimental Trials
- Conclusion 

General customizations that can be made to the experiment structure include:
- **Data saving frequency**
- **Background color**: The default options are white or gray.
- **Breaks**: Time perception experiments can be quite long. The number of breaks in the experimental trials segment can be specified. No breaks are integrated into the training segment.
- **Training Trials**: The number of training trials can be specified. These trials randomize stimuli and durations from the list from the options specified.

The following features are integrated in all experiments designed with this framework: 
- Users can press the "ESCAPE" key to exit the experiment at any time.
- Experimental trial data is saved to a datatable specific to each experiment type. Sample analysis scripts are provided.

## Reproduction Experiments
Time replication experiments assess how well a user can replicate a given time interval, indirectly assessing patients' working memory capacity as they temporarily store the interval duration before replicating it. The presented time intervals can be auditory or visual, and alternating (ABABAB) sequences are also supported. 

The following customizations can be made to the base experiment:
- **Replication Type**: There are several common ways for a participant to replicate the subjective duration of a visual or auditory stimulus. They include pressing a key to start and pressing a key to end the replicated interval, holding on a key for the subjective duration of the interval, and receiving a signal that the replicated interval has begun and pressing a key to stop the interval.
- **Durations**: The number and length of intervals 
- **Stimuli**: The default stimulus is a large circle. Any number of user defined images can be used as alternatives to the default stimulus.
- **Number of Trials**: The number of trials for each duration/stimulus combination can also be changed. Note that every duration specified will be matched with every stimulus specified, and the same number of trials will be applied to each duration/stimulus combination. 

## Comparison Experiments 
Time comparison experiments assesses how well a participant can determine the temporal relationship between two presented stimuli. There are two main types of comparison experiments: single and double comparison experiments. 

### Single Comparison Experiments
In single image experiments, participants are presented with one or more "standard" durations that they will make comparisons with throughout the rest of the experiment. In each trial, only a single image is presented and participants are asked to indicate how the duration of the presented stimulus relates to the standard duration(s). For example, when presented with a stimulus on a given trial, participants may be asked to press the "1" key if the stimulus duration felt longer than the standard duration and "2" if the stimulus duration felt shorter than the standard duration. 

Single comparison experiments can be customized in the following ways under this framework:
- **Comparison Type:** The nature of the comparison between trial durations and the standard duration can be customized by specifying whether the trial duration is _shorter or longer_ than the standard duration, _equal or unequal_ to the standard duration, or _shorter, equal, or longer_ than the standard duration. 
- **Stimulus:** The default stimulus is a large black circle. A user specified image may also be used. This version of the experiment is only designed for a single stimulus.
- **Standard Duration:** The duration of the standard image can be specified. Only one standard duration is supported under this version of the framework.
- **Comparison Durations:** Any number and length of stimulus durations to be compared with the standard duration can be specified.
- **Number of Trials:** The number of trials for each duration can also be changed. The same number of trials will be run for each duration. 

### Double Comparison Experiments
Double comparison experiments operate on the same principles as the single comparison experiments, except the standard duration is presented with the comparison duration on each trial. As a result, double comparison experiments enable a more direct measurement of time perception, and are less reliant on memory of the standard duration as opposed to single comparison experiments. Double comparison experiments have the additional advantage of randomizing the order of presentation of standard and comparison durations on each trial - making it easier to incorporate more stimuli without the awareness of the participant. 

Double comparison experiments can be customized in the following ways under this framework:
- **Comparison Type:** The nature of the comparison between trial durations and the standard duration can be customized by specifying whether the trial duration is _shorter or longer_ than the standard duration, _equal or unequal_ to the standard duration, or _shorter, equal, or longer_ than the standard duration.
- **Trial Order:** The order of the standard and comparison durations on each trial can be kept fixed or randomized.
- **Standard Stimuli:** The stimuli that will always be presented with the standard duration.
- **Comparison Stimuli:** The stimuli that will be compared with each standard stimulus. Different comparison stimuli may be directly compared with each standard stimulus. 
- **Standard Durations:** The duration of each standard stimulus, user provided or otherwise.
- **Comparison Durations:** Any number and length of stimulus durations to be compared with the standard durations can be specified.
- **Number of Trials:** The number of trials for each duration can also be changed. The same number of trials will be run for each duration. 


# How to customize experiments 
All experiments are customized using the parameters in that experiment's input file. Descriptions of each parameter are included in the input file. The parameters that can be changed are structured roughly as they are outlined above.  Examples of how to change the parameters to run each task follow in the "Example" sections. Only parameters relevant to the experiment at hand need to be changed and will be displayed in each example.  

Suppose for all experiments that we've downloaded the experiment code folder to the directory: "downloads/time_perception". We want to save our data after every five trials, the background to be white, and three breaks to be in our experiment. We want to run 10 training trials before our experiment begins and 10 trials for each duration (and stimulus, depending on the experiment). Let's assume for now that we're just running participant 1 on each experiment and using the image "default.jpg" for each experiment.

## Replication Experiment Example
Suppose we want to run a replication experiment with the default stimulus to assess how well participants can remember and distinguish between close together time intervals. Navigate to the "input_file_replication.m" file in the time_perception_replication folder. 

For this version of the experiment, we want participants to hold down on the space bar when they replicate intervals to respond. Since we want to use the default stimulus, we'll set the stimulus type accordingly. We will test the default stimulus on two durations - 1s, 2s - with ten trials for each duration so we can average them later on. We'll set these parameters in the Time Reproduction Task section. 

```
% General Parameters - to be changed for each operating system and experiment.
directory_link = "downloads/time_perception/time_perception_replication/";      % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 1;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 3;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 


% Parameters Specific to the Time Reproduction Task
replication_type = "hold";    % Choices: "start_stop", "hold", "stop"
stimulus_type = "default.jpg";     % Choices: "default", ["image path #1", "image path #2, ...].
durations = [1,2];                     % Durations to test per stimulus. Assumes same  durations for each stimulus.
num_trials = 10;                     % How many trials per duration-stimulus combination.

```


## Single Image Comparison Experiment Example

Suppose for the single image comparison experiment, we want to run a similar experiment - seeing how well participants can differentiate between close together intervals. Now, navigate to the "input_file_singlecomp.m" file in the "time_perception_single_comp" folder. Let's say we want to use the default stimulus for now and assess whether participants feel like the comparison durations are shorter or longer than the standard durations. We'll let the standard duration be 1 second, and compare it to three other intervals: 0.5s, 1s, and 1.5s.  

```
% General Parameters - to be changed for each operating system and experiment.
directory_link = "downloads/time_perception/time_perception_single_comparison/";      % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 1;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 3;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 

% Parameters Specific to the Time Comparison Task
comp_type = "shorter/longer";       % How should images be compared? 
                                        % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 
stimulus = "default";               % Choices: "default", or insert your own jpg image.
standard_duration = 1;             % Duration of standard image.  
comp_durations = [0.5, 1, 1.5];               % Durations for comparison images. 
num_comp_trials = 10;               % How many trials per duration being compared. 

```

## Double Image Comparison Experiment Example
Suppose for the double image comparison experiment, we want to run the example used for the single image comparison task, keeping the order of the standard and comparison images fixed. Now, navigate to the "input_file_doublecomp.m" file in the "time_perception_double_comp" folder. And change the parameters to the following:

```
% General Parameters - to be changed for each operating system and experiment.
directory_link = "downloads/time_perception/time_perception_double_comparison/";      % directory for experiment folders
save_after = 5;                     % Save data after __ trials.
participant_number = 0;             % participant number
background_color = "white";         % Choices: "white", "grey"
num_breaks = 1;                     % Number of breaks participants will have throughout the experiment.
num_training_trials = 5;            % Number of training trials to include before data collection. 

% Parameters Specific to the Time Comparison Task
comp_type = "shorter/longer";                     % How should images be compared? 
                                        % Choices: "shorter/longer", "equal/not equal", "shorter/equal/longer". 
comp_order = "fixed";          % Choices: "fixed", "random"
stimulus = "default";              % Preferred stimulus jpg file name or "default". The image to be used to represent standard and comparison durations. 
twoimage_standard_durations = [1, 2];   % Durations for standard images. Each duration will be used for each standard image.
twoimage_comp_durations = [0.5, 1, 1.5; 1.5, 2, 2.5];     % What comparison durations should be used relative to each standard duration? List in order of standard durations indicated above.
num_comp_trials = 10;            % How many trials to run for each standard/comparison duration
```


# How to run experiments 
Once you've entered in the parameters for your experiment of choice (and make sure you've set the participant_number, which will be used to save participant data), you're now ready to run the experiment! Simply write the name of your experiment's input file (i.e. input_file_replication, etc.) in the command window, press enter, and the experiment will begin! All instructions for the experiments will be presented to the participants before the task begins. 

# Known Issues

**KBQueueCheck keyboard device ID (may be OS/system-specific):** On some systems, `KBQueueCheck` does not reliably detect the correct keyboard device and must be set manually each run. If you run into this, try replacing the `KBQueueCheck`-based device ID with `-3`, which previously functioned as a reliable universal fallback. This issue may not affect all operating systems or users.

# Questions? 
If you have questions, comments, or concerns, feel free to reach out to Lily Gebhart at gebhart@stanford.edu. 

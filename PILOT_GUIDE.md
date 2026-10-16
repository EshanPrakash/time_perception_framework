# Installing and Running the Time Perception Experiments

This code runs three time perception experiments in MATLAB using Psychtoolbox:

| Experiment | Folder | Input file |
|---|---|---|
| Time reproduction | `time_perception_replication` | `input_file_replication.m` |
| Single comparison | `time_perception_single_comparison` | `input_file_singlecomp.m` |
| Double comparison | `time_perception_double_comparison` | `input_file_doublecomp.m` |

## 1. Install

**MATLAB.** The code was written on MATLAB R2024b. Install it with the **Image Processing Toolbox**, which the code uses to resize images (`imresize`).

**Psychtoolbox 3.0.19.16 ("Last Free Dessert").**
1. Download the 3.0.19.16 release from <https://github.com/Psychtoolbox-3/Psychtoolbox-3/releases> and unzip it somewhere permanent.
2. In MATLAB, navigate into the unzipped Psychtoolbox folder and run:
   ```
   SetupPsychtoolbox
   ```
3. Restart MATLAB, then run `PsychtoolboxVersion`. It should report 3.0.19.16.

Full Psychtoolbox installation instructions are at <http://psychtoolbox.org/download>.

**This code.** Download this repository and unzip it (on GitHub: Code, then Download ZIP).

No other packages are needed.

## 2. Set up an experiment

1. In MATLAB, navigate into the folder of the experiment you want to run (table above). MATLAB must be inside that folder, or it will not find the experiment's code and image.
2. Open the folder's input file. All settings are at the top of the file, each with a comment listing its options. Only edit the settings; do not edit the "Experiment Setup" section below them.

### Settings common to all experiments

| Setting | Meaning |
|---|---|
| `directory_link` | Leave as `""`. |
| `save_after` | Save data after every this-many trials. |
| `participant_number` | Used in the data file name. Use a different number for each participant. |
| `background_color` | `"white"` or `"grey"`. |
| `num_breaks` | Number of breaks during the main trials. |
| `num_training_trials` | Practice trials before data collection. |
| `stimulus_modality` | `"visual"`: image only. `"audio"`: tone only. `"both"`: image and tone together for the same duration. `"alternating"` (reproduction only): trials alternate between visual and audio. |
| `audio_frequency` | Tone frequency in Hz. Used when the modality includes audio. |
| `debug_mode` | If `true` and the stimulus is audio, a fixation cross is shown during the tone. |
| `stimulus` / `stimulus_type` | `"default.jpg"` (black circle), `"gaussian"` (Gaussian blob), or the file name of your own jpg placed in the experiment folder. |

For any modality that includes audio, use headphones and set the volume before starting.

### Reproduction settings

| Setting | Meaning |
|---|---|
| `replication_type` | `"hold"` (participant holds the key for the remembered duration), `"start_stop"` (press to start, press to stop), or `"stop"` (interval starts automatically, press to stop). |
| `durations` | Durations in seconds, e.g. `[1,2,3]`. |
| `num_trials` | Trials per duration (and per stimulus, if several are listed). |

### Single comparison settings

| Setting | Meaning |
|---|---|
| `comp_type` | `"shorter/longer"`, `"equal/not equal"`, or `"shorter/equal/longer"`. |
| `standard_duration` | The standard duration, in seconds. |
| `comp_durations` | Comparison durations, in seconds, e.g. `[0.5, 1, 1.5]`. |
| `num_comp_trials` | Trials per comparison duration. |

### Double comparison settings

| Setting | Meaning |
|---|---|
| `comp_type` | `"shorter/longer"`, `"equal/not equal"`, or `"shorter/equal/longer"`. |
| `comp_order` | `"random"`: standard and comparison appear in random order on each trial. `"fixed"`: standard always first. |
| `twoimage_standard_durations` | Standard durations in seconds, e.g. `[1, 2, 3]`. |
| `twoimage_comp_durations` | Matrix of comparison durations with **one row per standard** (same order as above) and one column per comparison. The default is 3 rows by 6 columns. |
| `num_comp_trials` | Trials per standard/comparison pair. |

Save the input file after editing.

## 3. Run

1. In the MATLAB command window, type the input file's name without `.m` and press Enter, for example:
   ```
   input_file_doublecomp
   ```
2. The experiment opens full screen and shows its instructions. Press the spacebar to move through them, then follow the on-screen instructions for responding.
3. Pressing ESC at any time exits the experiment. Data from completed trials is kept.

If the full-screen window does not close, type `sca` in the MATLAB command window and press Enter.

## 4. Data

Each run writes a new CSV file to the experiment folder's `results` folder:

```
results/dataP<participant_number>_<session id>.csv
```

The session id is a random UUID, so files from different runs never overwrite each other. The folder is created automatically.

Every file begins with these columns:

| Column | Meaning |
|---|---|
| `Session_ID` | UUID of the run. |
| `Participant` | The `participant_number` you set. |
| `Session_Start` | UTC start time of the run (ISO 8601). |
| `Trial` | Trial number. |

The experiment's own columns follow (stimulus, durations, `Modality`, `Response`), and the last column is `Trial_Datetime`, the UTC time of that trial's response. Data is saved every `save_after` trials, on ESC, and at the end of the experiment, and only completed trials are written.

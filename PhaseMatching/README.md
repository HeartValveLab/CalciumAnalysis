# Phase Matching

The phase matching program is used to determine the frames in a video corresponding to a particular phase in the heart cycle (e.g. P, Q, R, S, T).
It takes as input up to three channels of .tif files and outputs an .ome of .tif file with the phase matched frames.
There are three versions of the code available for users - 

- A GUI version
  - Interactive experience
  - Allows manual corrections
  - Does not require MATLAB license
- A verbose script version
  - Allows user to tweak aspects of code
  - Easy to follow and adjust
- A quiet script version
  - Abstracts away individual functions
  - Can save configuration from GUI
  - Run on supercomputer for large datasets

The main algorithm employed utilises MATLAB's inbuilt `multissim3` which allows each video frame to be compared to some user defined reference and 
generates a similarity score based on luminance, contrast, and structure. The frames with the peak values are deeemed to be in phase with the reference 
and can be saved for further processing. It also has a manual matching feature where users can manually choose which frame is more appropropriate when 
similarity scores within some threshold of the peak.

## Getting started

### Loading GUI
1. Setting up with a clone of this repository
    1. Open MATLAB
    2. Navigate to the folder you cloned this repository to or downloaded the release
    3. On the file explorer panel to the left, right click on PhaseMatching and add it to path
    4. Type in the command prompt `PhaseMatching_App` to open phase matching GUI
2. Or setting up with a copy of PhaseMatching.exe
    1. Go to the release page of the original repository and download the MyAppInstaller_mcr.exe
    2. Run the PhaseMatching.exe installer
    3. Follow prompts for installation
    4. Navigate to installation folder and run `PhaseMatching` application

### Using GUI
1. Initiate the input files and select a reference frame to match
    1. `Browse` for your working directory with the input tiff files
    2. `Browse` for your input tiff files - the code supports up to three channels
    3. Select the channel to be used for phase matching
    4. Select the frame to be used as a reference for phase matching
    5. Click `Set` to lock in variables and verify output figure to be used as reference
2. Perform a preliminary phase match
    1. Click `Run` to perform phase matching on whole image. The `NumScales` parameter can be tuned depending on input file size
    2. Click `Find Peaks` to determine the location of the phase matched frames. `MinPeakHeight` and `MinPeakProminence` can be tuned if the user wishes to detect more or less peaks
    3. Verify with the figure that all relevant peaks have been detected
3. Perform a region-specific phase matching
    1. Select either temporal, spatial, or hybrid correction option
        1. Temporal considers the sequential order of neighbouring frames
        2. Spatial picks the best neighbour
        3. Hybrid allows the user to choose for close calls within a threshold
    2. Indicate the number of additional frames to pad the time sequence with
    3. If using spatial correction, specify the number of neighbours around the peak to be checked
    4. If using hybrid correction, specify the threshold for requiring manual input. NOTE: the lower the value, the more manual correction that may need to be done
    5. After pressing `Run`, you will be required to draw a region of interest for the phase matching algorithm to target
    6. If you selected the hybrid option, you will also be required to manually correct by selecting on the pop up menu which image you think matches the reference better
4. Save output
    1. Select the output file type
        1. Individual tifs saves each frame as a separate tif file
        2. Single phase saves only the phase you are interested in
        3. All saves the phase of interest with some padding
        4. Session settings allows you to easily rerun code in a script
    2. Click `Save`
    
### Creating standalone application
1. In the GUI click on `Share` then `Standalone Desktop App`
2. Select `Runtime included in package`
3. Adjust any meta-information
4. `Package`
5. Once created, drag MyAppInstaller_mcr.exe under for_redistribution into release page of Github

### Script
1. Clone this repository
2. Open in MATLAB and folder to path
3. Follow instructions in BioProtocol

### Command line or computer cluster
```
cd Documents\GitHub\UROP\PhaseMatching
mat PhaseMatching_script
```

## TODO:
- [x] BUG: Some tif images not displaying - not code problem, dataset not scaled properly
- [x] TEST: Datasets on USB
- [x] TEST: Datasets on OneDrive
- [x] TEST: Datasets on SharedDrive
- [ ] TEST: Datasets on Vault
- [x] TEST: Automate testing
- [x] REVISE: Save session settings needs to reflect new code
- [x] REVISE: Outdated functions need removal
- [x] REVISE: Manual correction GUI information
- [x] REVISE: GUI unused variables
- [ ] ~~REVISE: Remove preliminary from quiet since we want it to run quickly~~ Dependency for temporal phase matching
- [ ] REVISE: Separate draw ROI function for modularity
- [x] FEATURE: Allow users to save after preliminary
- [x] FEATURE: Check to prevent overwrite files
- [ ] FEATURE: Display find peaks for temporal phase matching for better targeting
- [ ] ~~FEATURE: Flexible support of datatypes~~ Restrict user to filter data first
- [ ] ~~FEATURE: Deal with original file rather than requiring split or function to split~~ Just use ImageJ
- [x] DOCUMENT: How to use in README.md
- [x] RELEASE: Package GUI for release (test release done)
- [ ] CHECK: Instructions are easy to follow
- [ ] WRITE: Paper for protocol (BioProtocol?)

## Test results - datasets of interest to revisit
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\HajimeUSB\UseForTesting
    - High temporal and spatial resolution
    - Phase matching worked well
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_5
    - Short dataset - only 2 cycles
    - Output missing last cycle
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_7
    - Faint channel 1 performance vs bright channel 2
    - Better peak prominence with bright channel
    - Opening results in ImageJ reveals adjusted contrast
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_8
    - Cycle 12 off, check for better frame
    - Half phase encountered, compromise will be required
    - Potentially use a phase in the middle for average
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_9
    - Some noise but seemed to turn out alright
    - Check which channel was used and relative performance
    - Brighter channel with more contrast preferred
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Unsorted\Transfer_Files_10
    - Heart moves spatially
    - Interesting to see how it affects it
    - No prominent peaks observed - would not recommend too much movement
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_1
    - Stripey pattern on one of the channels - drops halfway
    - Noisey for the other channel - cuts off halfway
    - Compare performance - about the same
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_3
    - Very zoomed in dataset
    - Seems to not match well
    - Temporal matching needs fine tuning
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\SharedDrive\Zeiss\Zeiss_5
    - Also zoomed in, but seems to work well
    - Peaks are more prominent than before
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_1
    - Extremely noisey
    - See if salvageable - probably not, peaks are really bad
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\DL_191218\Data_3
    - Looks good overall but needs some ironing out with a couple of frames
    - Using just prelim seems fine. Need to fine tune temporal matching
    - Channel 2 signal seems a bit better
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\Renee_231118\Data_1
    - Double dataset
    - Really good overall but one mismatch
    - Middle frame reference works better
    - Allow tuning of temporal matching
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\Renee_231118\Data_2
    - Double dataset
    - Not great in terms of results
    - Need to allow manual manipulation of temporal peak finding
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\Renee_231118\Data_5
    - Cardiac cycle momentarily halts - will be interesting to see how phase match
    - Can't really know what happens since too noisy
    - Try using other data in that folder, seems less noisy
    - Some phases match well, others not too well
- C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\OneDrive\Renee_231118\Data_8
    - Output is quite off, probably due to noise



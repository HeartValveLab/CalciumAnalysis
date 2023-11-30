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
    a. Open MATLAB
    b. Navigate to the folder you cloned this repository to
    c. On the file explorer panel to the left, right click on PhaseMatching and add it to path
    d. Type in the command prompt `PhaseMatching_App` to open phase matching GUI
2. Or setting up with a copy of PhaseMatching.exe
    a. Run the PhaseMatching.exe installer
    b. Follow prompts for installation
    c. Run the installed application

### Using GUI
1. Initiate the input files and select a reference frame to match
    a. `Browse` for your working directory with the input tiff files
    b. `Browse` for your input tiff files - the code supports up to three channels
    c. Select the channel to be used for phase matching
    d. Select the frame to be used as a reference for phase matching
    e. Click `Set` to lock in variables and verify output figure to be used as reference
2. Perform a preliminary phase match
    a. Click `Run` to perform phase matching on whole image. The `NumScales` parameter can be tuned depending on input file size
    b. Click `Find Peaks` to determine the location of the phase matched frames. `MinPeakHeight` and `MinPeakProminence` can be tuned if the user wishes to detect more or less peaks
    c. Verify with the figure that all relevant peaks have been detected
3. Perform a region-specific phase matching
    a. Select either temporal, spatial, or hybrid correction option
        i. Temporal considers the sequential order of neighbouring frames
        ii. Spatial picks the best neighbour
        iii. Hybrid allows the user to choose for close calls within a threshold
    b. Indicate the number of additional frames to pad the time sequence with
    c. If using spatial correction, specify the number of neighbours around the peak to be checked
    d. If using hybrid correction, specify the threshold for requiring manual input. NOTE: the lower the value, the more manual correction that may need to be done
    e. After pressing `Run`, you will be required to draw a region of interest for the phase matching algorithm to target
    f. If you selected the hybrid option, you will also be required to manually correct by selecting on the pop up menu which image you think matches the reference better
4. Save output
    a. Select the output file type
        i. Individual tifs saves each frame as a separate tif file
        ii. Single phase saves only the phase you are interested in
        iii. All saves the phase of interest with some padding
        iv. Session settings allows you to easily rerun code in a script
    
### Script
1. Clone this repository
2. Open in MATLAB and folder to path
3. Follow instructions in BioProtocol

### Command line
```
cd Documents\GitHub\UROP\PhaseMatching
mat PhaseMatching_script
```

## TODO:
- [ ] BUG: Some tif images not displaying
- [x] TEST: New datasets on USB
- [ ] TEST: New datasets on OneDrive
- [ ] REVISE: Save session settings needs to reflect new code
- [ ] REVISE: Outdated functions need removal
- [ ] REVISE: Manual correction GUI information
- [ ] FEATURE: Allow users to save after preliminary
- [ ] FEATURE: Check to prevent overwrite files
- [x] DOCUMENT: How to use in README.md
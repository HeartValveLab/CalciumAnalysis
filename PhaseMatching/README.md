# Phase Matching

The phase matching program is designed to determine the frames in a video corresponding to a particular phase in the heart cycle (e.g. P, Q, R, S, T). It also has the potential to phase match other periodic biological processes. It takes as input up to three channels of .tif files and outputs a .ome or .tif file with the phase matched frames. There are three versions of the code available - 

- A GUI version
  - Interactive experience
  - Easily make manual corrections
  - Does not require MATLAB license
- A verbose script version
  - Allows user to tweak aspects of code
  - Easier to follow and adjust
- A quiet script version
  - Abstracts away individual functions
  - Can save configuration from GUI
  - Run on supercomputer for large datasets

The main algorithm utilises MATLAB's inbuilt `multissim3` which allows each video frame to be compared to some user defined reference and generates a similarity score based on luminance, contrast, and structure. The user canthen use the location of the peaks as indication of phase matched frames and can manually select or deselect additional locations to include in the final output.


## Getting started - for users

### Loading GUI
1. Setting up with a clone of this repository
    1. Open MATLAB
    2. Navigate to the folder you cloned this repository to or downloaded the release
    3. On the file explorer panel to the left, right click on `PhaseMatching` folder and add it to path
    4. Type in the command prompt `PhaseMatching_App` to open phase matching GUI
2. Or setting up with a copy of PhaseMatching.exe
    1. Go to the release page of the repository and download the MyAppInstaller_mcr.exe
    2. Run the PhaseMatching.exe installer
    3. Follow prompts for installation
    4. Navigate to installation folder and run `PhaseMatching` application

### Using GUI
1. Initiate the input files and select a reference frame to match
    1. `Browse` for your working directory with the input tiff files
    2. `Browse` for your input tiff files - the code supports up to three channels
    3. Select the channel to be used as a reference or phase matching
    4. Select the frame to be used as a reference for phase matching
    5. Click `Set` to lock in variables
    6. Verify output figure to be used as reference and draw a region of interest
2. Determine the similarity values
    1. Select either spatial or temporal method
        1. Spatial is faster
        2. Temporal considers the sequential order of neighbouring frames
    2. Adjust `NumScales` parameter if peaks are not very prominent
    3. `Run` the algorithm
3. Determine the location of the peaks
    1. `MinPeakHeight` and `MinPeakProminence` can be tuned if the user wishes to detect more or less peaks
    2. Click `Find Peaks` to automate finding most of the peaks
    3. Click on points on the figure to add or remove it from the peaks list
        1. Points already detected as peaks will be deselected
        2. Points not already detected will be selected
        3. Right-click on a point and `Export Cursor Data to Workspace`
        4. Always save it as `cursor_info` variable. **Note** that you will need to remove numbering for subsequent adjustments
    4. Click `Dedisplay` to set values and visualise output. **Note** that you can click it again to revert a change
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
3. Adjust any meta-information and ensure `loci_tools.jar` is included
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
- [ ] CHECK: Instructions are easy to follow
- [ ] WRITE: Paper for protocol

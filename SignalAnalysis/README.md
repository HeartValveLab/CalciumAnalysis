# Signal Analysis

The signal analysis program was designed to streamline the analysis of the calcium signal. There are three versions available - 

- A GUI version
  - Interactive experience
  - Does not require MATLAB license
- A verbose script version
  - Allows user to tweak aspects of code
  - Easier to follow and adjust
- A quiet script version
  - Abstracts away individual functions
  - Can save configuration from GUI
  - Run on supercomputer for large datasets

The signals for each channel were calculated using MATLAB's inbuilt `regionprops` function to get the mean intensity for the region of interest in each frame. The calcium signal was then normalised against the baseline, where
$$baseline=\min \frac{calcium}{nuclear}$$
and
$$normalised=\frac{\frac{calcium}{nuclear}-baseline}{baseline}.$$

## Getting started

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
1. Initiate the input files
2. Overlay the frames for each channel
3. Select a region of interest
4. Plot signals of desire

### Running script
1. Clone this repository
2. Open in MATLAB and add folder to path
3. Adjust input parameters as required
4. `Run` the script

## Extra information for developers
### Creating standalone application
1. In the GUI click on `Share` then `Standalone Desktop App`
2. Select `Runtime included in package`
3. `Package`
4. Once created, drag MyAppInstaller_mcr.exe under for_redistribution into release page of Github

### TODO:
- [x] UPDATE: Readme information
- [ ] UPDATE: Include use of classes to tidy up code
- [ ] FEATURE: Prevent overwrite and unnecessary saving (save via figure?)
- [ ] FEATURE: Automatically close figures to prevent clogging up (or use figure numbers)
- [ ] TEST: Automate testing of code
- [ ] CHECK: Instructions are easy to follow
- [ ] WRITE: Paper for protocol
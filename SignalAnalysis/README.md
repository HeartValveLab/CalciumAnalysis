# Signal Analysis

The signal analysis program was designed to streamline the analysis of the calcium signal and also integrates the overlay feature within it. There are three versions available - 

- A GUI version
  - Interactive experience
  - Does not require MATLAB license
- A verbose script version
  - Allows user to tweak aspects of code
  - Easier to follow and adjust
- A quiet script version
  - Abstracts away individual functions
  - Can save configuration from GUI

The signals for each channel were calculated using MATLAB's inbuilt `regionprops` function to get the mean intensity for the region of interest in each frame. The calcium signal can then be normalised against the reference channel, where
$$baseline=\min \frac{calcium}{reference}$$

$$normalised=\frac{\frac{calcium}{reference}-baseline}{baseline}.$$

Alternatively, it can be normalised against itself, where
$$baseline=\min calcium$$

$$normalised = \frac{calcium-baseline}{baseline}$$

## Getting started - for users

### Download and Install GUI
1. Setting up with a clone of this repository - recommend if you already have MATLAB
	1. Open MATLAB
	2. Navigate to the folder you cloned this repository to or downloaded the release
	3. On the file explorer panel to the left, right click on `SignalAnalysis` folder and add it to path
	4. Type in the MATLAB command prompt `SignalAnalysis_App` to open the Signal Analysis GUI
2. Or setting up with a copy of SignalAnalysis_Installer.exe
	1. Go to the release page of the repository and download the SignalAnalysis_Installer.exe
	2. Run SignalAnalysis_Installer.exe
	3. Follow prompts for installation. **Note** that Mac and Linux users may need to download the R2022b runtime separately via https://au.mathworks.com/products/compiler/matlab-runtime.html
	4. Navigate to the folder where you installed the application and run `SignalAnalysis` 

### Using GUI
Details available in protocol.
1. Initiate the input files
2. Overlay the frames for each channel
3. Select a region of interest
4. Plot signals of desire

### Running Script
1. Clone this repository
2. Open in MATLAB and add folder to path
3. Adjust input parameters as required
4. `Run` the script

## Extra Information for Developers
### Creating standalone application
1. Download R2022b runtime from https://au.mathworks.com/products/compiler/matlab-runtime.html
2. Add it in Preference>MATLAB Compiler - helpful link if case you get stuck https://au.mathworks.com/matlabcentral/answers/402422-why-do-i-receive-a-runtime-not-found-prompt-when-creating-a-standalone-application-using-matlab-co
3. In the .mlapp file click on `Share` then `Standalone Desktop App`
4. Select `Runtime included in package`. Make the name SignalAnalysis_Installer.
5. `Package`
6. Once created, drag SignalAnalysis_Installer.exe under for_redistribution into release page of Github
7. You can use SignalAnalysis.exe for testing on local machine and track errors in .log file

### TODO:
- [x] UPDATE: Readme information
- [x] FEATURE: Automatically close figures to prevent clogging up (or use figure numbers)
- [x] FEATURE: Select region of interest channel option and display
- [x] FEATURE: Overlay display both channels overlayed.
- [ ] CHECK: Instructions are easy to follow
- [ ] WRITE: Paper for protocol
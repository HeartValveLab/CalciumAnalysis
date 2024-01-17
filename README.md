# UROP

This GitHub repository documents the code worked on by Raymond Zhang during his UROP placement at the Australian Regenerative Medicine Institute.
The project involved programming in Matlab to help build new software to analyse fluorescent images of the beating heart.
It is based on Renee Chow and Hajime Fukui's MATLAB code for phase matching the cardiac cycle, and makes further improvements on it.
There are two main applications developed here - 

1. Phase Matching
2. Signal vs Time

## Getting Started - For Users
1. Download and unzip the `Assets` under `Calcium Analysis` in the `Releases` on the right-hand side of this GitHub page.
2. If you already have MATLAB
	1. Open MATLAB
	2. Navigate to the folder you unzipped the `Source Code` in the file explorer panel to the left
	3. Right click on `PhaseMatching` to add selected folder and subfolders to path
	4. Right click on `SignalAnalysis` to add selected folder and subfolders to path
	- To use GUI: type in MATLAB command window `PhaseMatching_App` or `SignalAnalysis_App` the application you want to open
	- To use script: expand folder for application of choice and double click on `<application>_Verbose.m` script
3. If you don't have MATLAB
	1. Run `PhaseMatching_Installer.exe` and `SignalAnalysis_Installer.exe` that you downloaded from the releases. It may take a moment to load.
	2. Follow the prompts for installation. **Note** that Mac and Linux users may need to download the R2022b runtime separately via https://au.mathworks.com/products/compiler/matlab-runtime.html
	3. Navigate to the folder you installed the application and run it

Details for using each application is specified in the protocol available [here](https://armi.org.au/our-groups/chow-group/).
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

The main algorithm utilises MATLAB's inbuilt `multissim3` which allows each video frame to be compared to some user defined reference and generates a similarity score based on luminance, contrast, and structure. The user can then use the location of the peaks as indication of phase matched frames and can manually select or deselect additional locations to include in the final output.


## Getting started - for users

### Loading GUI
1. Setting up with a clone of this repository
    1. Open MATLAB
    2. Navigate to the folder you cloned this repository to or downloaded the release
    3. On the file explorer panel to the left, right click on `PhaseMatching` folder and add it to path
    4. Type in the command prompt `PhaseMatching_App` to open phase matching GUI
2. Or setting up with a copy of PhaseMatching_Installer.exe
    1. Go to the release page of the repository and download the PhaseMatching_Installer.exe
    2. Run the PhaseMatching_Installer.exe
    3. Follow prompts for installation. **Note** that Mac and Linux users may need to download the R2022b runtime separately via https://au.mathworks.com/products/compiler/matlab-runtime.html
    4. Navigate to folder you installed the app and run `PhaseMatching` application

### Using GUI
Details available in protocol.
1. Initiate the input files and select a reference frame to match
2. Determine the similarity values
3. Determine the location of the peaks
4. Save output
    
### Running script
1. Clone this repository
2. Open in MATLAB and add folder to path
3. Adjust input parameters as required
4. `Run` the script


## Extra information for developers

### Creating standalone application
1. Download R2022b runtime from https://au.mathworks.com/products/compiler/matlab-runtime.html
2. Add it in Preference>MATLAB Compiler - helpful link if case you get stuck https://au.mathworks.com/matlabcentral/answers/402422-why-do-i-receive-a-runtime-not-found-prompt-when-creating-a-standalone-application-using-matlab-co
3. In the .mlapp file click on `Share` then `Standalone Desktop App`
4. Select `Runtime included in package`. Make the name PhaseMatching_Installer.
5. `Package`
6. Once created, drag PhaseMatching_Installer.exe under for_redistribution into release page of Github
7. You can use PhaseMatching.exe for testing on local machine and track errors in .log file

### Command line
```
cd Documents\GitHub\UROP\PhaseMatching
mat PhaseMatching_script
```

### TODO:
- [ ] CHECK: Instructions are easy to follow
- [ ] WRITE: Paper for protocol
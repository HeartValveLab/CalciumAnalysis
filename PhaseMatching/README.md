# Phase Matching

The phase matching program was designed to determine the frames in a video corresponding to a particular phase in the heart cycle (e.g. P wave). It takes at input upto three .tif files and outputs an .ome file with the phase matched frames. There are two versions of the code available for users - 

- A GUI version
  - Interactive experience
  - Allows manual corrections
  - Does not require MATLAB license
- A script version
  - Saving configurations
  - Running large datasets on supercomputer

The main algorithm employed utilises MATLAB's inbuilt `multissim3` which allows each video frame to be compared to some user defined reference and generates a similarity score based on luminance, contrast, and structure. The frames with the peak values are deeemed to be in phase with the reference and can be saved for further processing.

## Getting started
### GUI
1. Download PhaseMatching.exe from this GitHub repository
2. Download and install [MATLAB Runtime](https://au.mathworks.com/products/compiler/matlab-runtime.html) version R2022b (9.13)
3. Run PhaseMatching.exe
4. Follow instructions in BioProtocol

### Script
1. Clone this repository
2. Open in MATLAB and folder to path
3. Follow instructions in BioProtocol

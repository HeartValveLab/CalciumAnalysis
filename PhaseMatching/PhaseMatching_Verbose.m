%% %% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-11-01

% close all; clc; clear;
addpath(genpath('utility'))


%% USERS INPUTS
disp('Initialising inputs');

InputData = input_data;
InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
InputData.filename_1 = '0-499-Nuc.tif';
InputData.filename_2 = '0-499-Ca.tif';   % optional
InputData.filename_3 = '';               % optional

InputData.main_ch = 2; % channel to be used for reference
InputData.phase = 15;  % frame to be used for reference

InputParams = input_params;
InputParams.n_scales = 5;
InputParams.min_peak_height = 0;
InputParams.min_peak_prominence = 0.05;
InputParams.ROI = [0.5, 0.5, InputData.width, InputData.height]; %[236, 183, 338, 337];     % x_start, y_start, x_end, y_end
InputParams.padding = 3;

MatchingMode = 'spatial';

Visibility = 'on'; % display figures or not
OutputFolder = 'PhaseMatchingOutput';
Output = '011';

disp('Inputs initialised');


%% Initiation
disp('Processing user inputs');
ImgRef = InputData.get_img;
f1 = figure(1);
f1.Visible = Visibility;
imshow(ImgRef);
title('This is our reference image for phase matching')
disp('User inputs processed')


%% Calculate similarity scores
disp('Determining similarity scores.');

switch MatchingMode
    case 'spatial'
        SsimScores = spatial_phase_matching(InputData, InputParams);
    case 'temporal'
        SsimScores = temporal_phase_matching(InputData, InputParams);
end

f2 = figure(2);
f2.Visible = Visibility;
plot(SsimScores);
title('Similarity scores for each frame')

disp('Similarity scores calculated. Determine peak locations.')


%% Finding peaks
disp('Determining location of peaks.');
[Pks, PkLocs, N_pks, MeanDist] = find_peaks(SsimScores, InputParams.min_peak_height, InputParams.min_peak_prominence, 0, InputData.phase);
f2 = figure(2);
f2.Visible = Visibility;
plot(SsimScores); hold on;
plot(PkLocs, Pks, "*");
title('Similarity scores for each frame')
disp('Peaks located.');


%% Update peaks
try
    cursor_info = evalin('base', 'cursor_info');
    [Pks, PkLocs, N_pks, MeanDist] = update_peaks(cursor_info, Pks, PkLocs);
catch
    
end
f2 = figure(2);
f2.Visible = Visibility;
plot(SsimScores); hold on;
plot(PkLocs, Pks, "*");
title('Similarity scores for each frame')


%% Create movie
CutLength = InputParams.cut_length(MeanDist);
ImagesToSave = cell(InputData.n_channels, N_pks, 2*CutLength+1);
ImagesToSave = construct_movie(InputData.file_paths, ImagesToSave, PkLocs, CutLength);


%% Output
disp('Saving files');
OutputPath = [InputData.folder_path, OutputFolder];
mkdir(OutputPath);
javaaddpath('loci_tools.jar')

if Output(1) == '1'
    save_multitiff(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
end
if Output(2) == '1'
    ImageFile=['SinglePhase_z' padnumber(3,num2str(InputData.phase)) '.ome'];
    if isfile([OutputPath,filesep,ImageFile])
        disp('File already exists. Overwrite prevented. Consider renaming original file.')
    else
        save_single_phase(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
    end
end
if Output(3) == '1'
    ImageFile = ['AllPhase.ome'];
    if isfile([OutputPath,filesep,ImageFile])
        disp('File already exists. Overwrite prevented. Consider renaming original file')
    else
        save_all_phase(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
    end
end
disp('Files saved');
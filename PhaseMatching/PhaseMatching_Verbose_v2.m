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

% InputData = input_data;
% InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
% InputData.filename_1 = '0-499-Nuc.tif';
% InputData.filename_2 = '0-499-Ca-uint16.tif';   % optional
% InputData.filename_3 = '';               % optional

InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\HajimeUSB\UseForTesting\';
InputData.filename_1 = 'SingleFile-Ch1.tif';
InputData.filename_2 = 'SingleFile-Ch2.tif';   % optional
InputData.filename_3 = '';               % optional

% InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle_full\';
% InputData.filename_1 = '0-4499-Nuc.tif';
% InputData.filename_2 = '0-4499-Ca.tif';   % optional
% InputData.filename_3 = '';               % optional
% 
% InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\Cilia\';
% InputData.filename_1 = 'injured_motile_Rep_8_bit.tif';
% InputData.filename_2 = '';   % optional
% InputData.filename_3 = '';               % optional

InputData.main_ch = 2; % channel to be used for reference
InputData.phase = 15;  % frame to be used for reference

InputParams = input_params;
InputParams.n_scales = 5;
InputParams.min_peak_height = 0;
InputParams.min_peak_prominence = 0.05;

InputParams.ROI = [236, 183, 338, 337];     % x_start, y_start, x_end, y_end
%InputParams.ROI = [0.5, 0.5, 144, 136];
InputParams.padding = 3;
InputParams.n_neighbours = 2;

Visibility = 'on'; % display figures or not
OutputFolder = 'PhaseMatchingOutput';
Output = '010';

disp('Inputs initialised');


%% Initiation
disp('Processing user inputs');
ImgRef = InputData.get_img;
figure('Visible',Visibility);
imshow(ImgRef);
title('This is our reference image for phase matching')
disp('User inputs processed')


%% Preliminary Phase Matching
disp('Performing preliminary phase matching');
SsimScoresMain = ssim_wrapper(ImgRef, InputData.main_path, 1:InputData.width, 1:InputData.height, 1:InputData.n_frames, InputParams.n_scales);
[Pks, PkLocs, N_pks, MeanDist] = find_peaks_v2(SsimScoresMain, InputParams.min_peak_height, InputParams.min_peak_prominence, 0, InputData.phase);

figure('Visible',Visibility);
plot(1:InputData.n_frames, SsimScoresMain); hold on;
plot(PkLocs, Pks, "*")
title(['ssim scores. ', num2str(N_pks), ' peaks found at an average distance of ', num2str(MeanDist)])
disp('Preliminary phase matching complete')


%% ROI Based Phase Matching
disp('Performing advanced phase matching');
% [Pks, MatchedFrames, N_pks, MeanDist, SsimsTotal] = temporal_phase_matching(InputData, InputParams, MeanDist);
[MatchedFrames] = best_neighbour_phase_matching(InputData, InputParams, PkLocs);

% figure('Visible',Visibility);
% plot(1:InputData.n_frames-1, SsimsTotal); hold on;
% plot(MatchedFrames, Pks, "*")
% title(['ssim scores. ', num2str(N_pks), ' peaks found at an average distance of ', num2str(MeanDist)])
% disp('Preliminary phase matching complete')

disp('Advanced phase matching complete');


%% Create movie
CutLength = InputParams.cut_length(MeanDist);
ImagesToSave = cell(InputData.n_channels, N_pks, 2*CutLength+1);
ImagesToSave = construct_movie(InputData.file_paths, ImagesToSave, MatchedFrames, CutLength);


%% Output
disp('Saving files');
OutputPath = [InputData.folder_path, OutputFolder];
mkdir(OutputPath);
javaaddpath('loci_tools.jar')

if Output(1) == '1'
    save_multitiff(InputData, CutLength, ImagesToSave, N_pks, OutputPath)
end
if Output(2) == '1'
    save_single_phase(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
end
if Output(3) == '1'
    save_all_phase(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
end
disp('Files saved');
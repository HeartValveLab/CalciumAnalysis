%% %% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-09-27

close all; clc; clear;
addpath(genpath('utility'))

%% USERS INPUTS
disp('Initialising inputs');

FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
FilenameCh1 = '0-499-Nuc.tif';
FilenameCh2 = '0-499-Ca.tif';   % optional
FilenameCh3 = '';               % optional

MainCh = 1; % channel to be used for reference
Phase = 7;  % frame to be used for reference

NumScales = 5;
MinPeakHeight = 0;
MinPeakProminence = 0.05;

ROI = [236, 183, 338, 337];     % x_start, y_start, x_end, y_end
Padding = 3;
CheckNeighbours = 2;
Visibility = 'on'; % display figures or not
OutputFolder = 'PhaseMatchingOutput';
Output = '111';

%% Initiation
disp('Processing user inputs');
[FilePaths, N_channels, MainPath, TifInfo, ImgRef] = initialise_phase_matching(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase);
figure('Visible',Visibility);
imshow(ImgRef);
title('This is our reference image for phase matching')
disp('User inputs processed')


%% Preliminary Phase Matching
disp('Performing preliminary phase matching');
[SsimScores, N_Frames] = pre_phase_matching(TifInfo, MainPath, ImgRef, NumScales);
[Pks, PkLocs, N_pks, MeanDist] = find_peaks(SsimScores, MinPeakHeight, MinPeakProminence, Phase);

figure('Visible',Visibility);
plot(1:N_Frames, SsimScores); hold on;
plot(PkLocs, Pks, "*")
title(['ssim scores. ', num2str(N_pks), ' peaks found at an average distance of ', num2str(MeanDist)])
disp('Preliminary phase matching complete')


%% ROI Based Phase Matching
disp('Performing advanced phase matching');
CutLength = round(MeanDist/2 + Padding);
ImagesToSave = cell(N_channels, N_pks,2*CutLength+1);
X_bounds = ceil(ROI(1)):floor(ROI(1)+ROI(3));
Y_bounds = ceil(ROI(2)):floor(ROI(2)+ROI(4));
N_neighbours = CheckNeighbours;
ImagesToSave = adv_phase_matching(N_pks, MainPath, X_bounds, Y_bounds, ImgRef, PkLocs, N_neighbours, CutLength, N_channels, TifInfo, ImagesToSave, FilePaths);


%% Output
disp('Saving files');
OutputPath = [FolderPath, OutputFolder];
mkdir(OutputPath);
javaaddpath('loci_tools.jar')

if Output(1) == '1'
    save_multitiff(N_pks, N_channels, CutLength, ImagesToSave, OutputPath)
end

if Output(2) == '1'
    save_single_phase(TifInfo, N_pks, N_channels, CutLength, ImagesToSave, OutputPath, Phase);
end

if Output(3) == '1'
    save_all_phase(TifInfo, N_pks, N_channels, CutLength, ImagesToSave, OutputPath);
end
disp('Files saved');
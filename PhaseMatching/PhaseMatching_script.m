%% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-07-24

close all; clc;


%% USERS INPUTS
% TODO: allow for external input of arguments
% TODO: compile code?
FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\PhaseMatching\data\CardiacCycle\';
FilenameCh1 = '0-499-Nuc.tif';
FilenameCh2 = '0-499-Ca.tif';   % optional
FilenameCh3 = '';               % optional

MainCh = 1; % channel to be used for reference
Phase = 1;  % frame to be used for reference

NumScales = 5;
MinPeakHeight = 0;
MinPeakProminence = 0.05;

ROI = [236, 183, 338, 337];
Padding = 3;
CheckNeighbours = 2;

OutputName = 'PhaseMatchingOutput';
Output = '111';


%% Initiation
[pathnames, N_channels, pathnameChMain, tifInfo, img_ref] = initialise(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase);
% figure(1);
% imshow(img_ref);
% title('This is our reference image for phase matching')


%% Preliminary Phase Matching
[ssim_score_lst, N] = pre_phase_matching(tifInfo, pathnameChMain, img_ref, NumScales);

figure(2);
plot(1:N, ssim_score_lst);
hold on;
title('ssim scores');

[pks, pk_locs, N_pks] = find_peaks(ssim_score_lst, MinPeakHeight, MinPeakProminence, Phase);

figure(2);
plot(pk_locs, pks, "*")


%% ROI Based Phase Matching
[cutLength, ImagesToSave] = init_output(pk_locs, Padding, N_channels, N_pks);

xbounds = ceil(ROI(1)):floor(ROI(1)+ROI(3));
ybounds = ceil(ROI(2)):floor(ROI(2)+ROI(4));
n_neighbours = CheckNeighbours;

ImagesToSave = adv_phase_matching(N_pks, pathnameChMain, xbounds, ybounds, Phase, pk_locs, n_neighbours, cutLength, N_channels, tifInfo, ImagesToSave, pathnames);


%% Output
outputFolder = OutputName;
outputFileName = OutputName;
folder_w = [FolderPath, outputFolder];
mkdir(folder_w);
javaaddpath('loci_tools.jar')

if Output(1) == '1'
    save_multitiff(N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w)
end

if Output(2) == '1'
    save_phase(tifInfo, N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w, Phase);
end

if Output(3) == '1'
    save_all(tifInfo, N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w);
end

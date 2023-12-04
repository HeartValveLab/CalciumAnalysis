%% %% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-09-27

close all; clc; %clear;
addpath(genpath('utility'))

%% USERS INPUTS
disp('Reading user inputs');

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

%% RUN CODE
run_phase_matching(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, ...
    MainCh, Phase, NumScales, MinPeakHeight, MinPeakProminence, Padding, ...
    ROI, CheckNeighbours, Visibility, OutputFolder, Output);

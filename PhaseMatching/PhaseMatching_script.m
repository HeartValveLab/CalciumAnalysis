%% %% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-08-22

close all; clc; %clear;
addpath(genpath('utility'))

%% USERS INPUTS
disp('Initialising inputs');

FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\PhaseMatching\data\CardiacCycle\';
FilenameCh1 = '0-499-Nuc.tif';
FilenameCh2 = '0-499-Ca.tif';   % optional
FilenameCh3 = '';               % optional

MainCh = 1; % channel to be used for reference
Phase = 1;  % frame to be used for reference

NumScales = 5;
MinPeakHeight = 0;
MinPeakProminence = 0.05;

ROI = [236, 183, 338, 337];     % x_start, y_start, x_end, y_end
Padding = 3;
CheckNeighbours = 2;

OutputName = 'PhaseMatchingOutput';
Output = '000';

%% RUN CODE
phase_matching_script(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, ...
    MainCh, Phase, NumScales, MinPeakHeight, MinPeakProminence, Padding, ...
    ROI, CheckNeighbours, OutputName, Output);

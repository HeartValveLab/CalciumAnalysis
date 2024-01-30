%% %% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-12-05

close all; clc; %clear;
addpath(genpath('utility'))

%% USERS INPUTS
disp('Reading user inputs');

InputData = input_data;
InputParams = input_params;

InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
InputData.filename_1 = '0-499-Nuc.tif';
InputData.filename_2 = '0-499-Ca.tif';   % optional
InputData.filename_3 = '';               % optional
InputData.main_ch = 1; % channel to be used for reference
InputData.phase = 7;  % frame to be used for reference

InputParams.n_scales = 5;
InputParams.min_peak_height = 0;
InputParams.min_peak_prominence = 0.05;
InputParams.ROI = [236, 183, 338, 337];     % x_start, y_start, x_end, y_end
InputParams.padding = 3;
InputParams.n_neighbours = 2;

MatchingMode = 'spatial';
Visibility = 'on'; % display figures or not
OutputFolder = 'PhaseMatchingOutput';
Output = '010';

%% RUN CODE
run_phase_matching(InputData, InputParams, Visibility, OutputFolder, Output, MatchingMode);

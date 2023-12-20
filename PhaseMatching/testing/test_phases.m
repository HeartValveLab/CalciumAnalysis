function message = test_phase_var(phase)
% TEST_PHASE_VAR is a header function to allow for testing of different
% phases. Simply copy over any new code and run test to ensure code does
% not break for different phases.
addpath(genpath('utility'))


%% USERS INPUTS
disp('Initialising inputs');

InputData = input_data;
InputData.folder_path = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
InputData.filename_1 = '0-499-Nuc.tif';
InputData.filename_2 = '0-499-Ca.tif';   % optional
InputData.filename_3 = '';               % optional

InputData.main_ch = 1; % channel to be used for reference
InputData.phase = phase;  % frame to be used for reference

InputParams = input_params;
InputParams.n_scales = 5;
InputParams.min_peak_height = 0;
InputParams.min_peak_prominence = 0.005;

InputParams.ROI = [236, 183, 338, 337];     % x_start, y_start, x_end, y_end
%InputParams.ROI = [0.5, 0.5, 144, 136];
InputParams.padding = 3;
InputParams.n_neighbours = 2;

MatchingMode = 'spatial';
Visibility = 'on'; % display figures or not
OutputFolder = 'PhaseMatchingOutput';
Output = '010';

disp('Inputs initialised');

run_phase_matching(InputData, InputParams, Visibility, OutputFolder, Output, MatchingMode);


%% DO NOT REMOVE
close all; % optional
message = "Test ran to completion";
end
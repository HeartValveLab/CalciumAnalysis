function message = test_file(folder_path, filename_1, filename_2)
% TEST_FILE is a header function to allow for testing of different
% files. Simply copy over any new code and run test to ensure code does
% not break for different phases.
addpath(genpath('utility'))


%% USERS INPUTS
disp('Initialising inputs');

InputData = input_data;
InputData.folder_path = folder_path;
InputData.filename_1 = filename_1;
InputData.filename_2 = filename_2;   % optional
InputData.filename_3 = '';               % optional

InputData.main_ch = 1; % channel to be used for reference
InputData.phase = 5;  % frame to be used for reference

InputParams = input_params;
InputParams.n_scales = 5;
InputParams.min_peak_height = 0;
InputParams.min_peak_prominence = 0.005;

InputParams.ROI = [0.5, 0.5, InputData.width, InputData.height];     % x_start, y_start, x_end, y_end
InputParams.padding = 3;
InputParams.n_neighbours = 2;

Visibility = 'on'; % display figures or not
OutputFolder = 'PhaseMatchingOutput';
Output = '010';

disp('Inputs initialised');

run_phase_matching(InputData, InputParams, Visibility, OutputFolder, Output);

%% DO NOT REMOVE
close all; % optional
message = "Test ran to completion";
end
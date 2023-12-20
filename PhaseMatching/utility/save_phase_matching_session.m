function save_phase_matching_session(input_data, input_params, output_name, matching_mode)
% SAVE_PHASE_MATCHING_SESSION allows users to save GUI inputs as a MATLAB
% script that can be run on a high performance computer
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-12-20
% ------INPUTS------
% input_data (class):           Class structure containing input dataset
% input_params (class):         Class structure containing input variables
% output_name (str):            Output folder name
% output_type (str):            Type of 
% -----OUTPUTS-----
% PhaseMatchingSession.mat:     MATLAB script
    folder_w = [input_data.folder_path, output_name];
    fid = fopen([folder_w, '\PhaseMatchingSession_', datestr(now, 'ddmmyyyy_HHMMSS'), '.m'], 'wt' );
    fprintf(fid, '%%%% Phase Matching\n');
    fprintf(fid, '%% A condensed script version of the Phase Matching GUI app.\n');
    fprintf(fid, '%% It allows users to rerun the code with the settings they inputted in the GUI.\n');
    fprintf(fid, '%% This is particularly useful if datasets are large and require supercomputer.\n');
    fprintf(fid, '%% It already contains everything necessary to be run by itself as a script.\n');

    fprintf(fid, 'close all; clc; clear; \n');
    fprintf(fid, "addpath(genpath('utility'))\n\n\n");
    
    fprintf(fid, '%%%% USER INPUTS\n');
    fprintf(fid, "disp('Reading user inputs');\n");
    fprintf(fid, "InputData = input_data;\n");
    fprintf(fid, "InputParams = input_params;\n");
    fprintf(fid, "InputData.folder_path = '%s';\n", input_data.folder_path);
    fprintf(fid, "InputData.filename_1 = '%s';\n", input_data.filename_1);
    fprintf(fid, "InputData.filename_2 = '%s';   %% optional\n", input_data.filename_2);
    fprintf(fid, "InputData.filename_3 = '%s';   %% optional\n\n", input_data.filename_3);
    
    fprintf(fid, "InputData.main_ch = %i; %% channel to be used for reference\n", input_data.main_ch);
    fprintf(fid, "InputData.phase = %i;  %% frame to be used for reference\n\n", input_data.phase);
    
    fprintf(fid, "InputParams.n_scales = %i;\n", input_params.n_scales);
    fprintf(fid, "InputParams.min_peak_height = %i;\n", input_params.min_peak_height);
    fprintf(fid, "InputParams.min_peak_prominence = %i;\n\n", input_params.min_peak_prominence);
    
    fprintf(fid, "InputParams.ROI = [%i, %i, %i, %i];     %% x_start, y_start, x_end, y_end\n", input_params.ROI);
    fprintf(fid, "InputParams.padding = %i;\n", input_params.padding);
    fprintf(fid, "MatchingMode = '%s';\n", matching_mode);
    fprintf(fid, "Visibility = 'off'; %% display figures or not\n");
    fprintf(fid, "OutputFolder = '%s';\n", output_name);
    fprintf(fid, "Output = '010';\n\n");
    
    fprintf(fid, '%%%% RUN CODE\n');
    fprintf(fid, "run_phase_matching(InputData, InputParams, Visibility, OutputFolder, Output, MatchingMode);\n");
    fclose(fid);
end
function save_phase_matching_session(InputData, InputParams, OutputName)
    %% Save settings
    folder_w = [InputData.folder_path, OutputName];
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
    fprintf(fid, "InputData.folder_path = '%s';\n", InputData.folder_path);
    fprintf(fid, "InputData.filename_1 = '%s';\n", InputData.filename_1);
    fprintf(fid, "InputData.filename_2 = '%s';   %% optional\n", InputData.filename_2);
    fprintf(fid, "InputData.filename_3 = '%s';   %% optional\n\n", InputData.filename_3);
    
    fprintf(fid, "InputData.main_ch = %i; %% channel to be used for reference\n", InputData.main_ch);
    fprintf(fid, "InputData.phase = %i;  %% frame to be used for reference\n\n", InputData.phase);
    
    fprintf(fid, "InputParams.n_scales = %i;\n", InputParams.n_scales);
    fprintf(fid, "InputParams.min_peak_height = %i;\n", InputParams.min_peak_height);
    fprintf(fid, "InputParams.min_peak_prominence = %i;\n\n", InputParams.min_peak_prominence);
    
    fprintf(fid, "InputParams.ROI = [%i, %i, %i, %i];     %% x_start, y_start, x_end, y_end\n", InputParams.ROI);
    fprintf(fid, "InputParams.padding = %i;\n", InputParams.padding);
    fprintf(fid, "InputParams.n_neighbours = %i;\n\n", InputParams.n_neighbours);
    fprintf(fid, "Visibility = 'off'; %% display figures or not\n");
    fprintf(fid, "OutputFolder = '%s';\n", OutputName);
    fprintf(fid, "Output = '010';\n\n");
    
    fprintf(fid, '%%%% RUN CODE\n');
    fprintf(fid, "run_phase_matching(InputData, InputParams, Visibility, OutputFolder, Output);\n");
    fclose(fid);
end
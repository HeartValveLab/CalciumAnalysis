function save_signal_analysis(folder_path, filename_nuc, filename_ca, start_frame, end_frame, output_folder, exposure_time, mean_dist)
    %% Save settings
    folder_w = [folder_path, output_folder];
    fid = fopen([folder_w, '\SignalAnalysisSession_', datestr(now, 'ddmmyyyy_HHMMSS'), '.m'], 'wt' );
    fprintf(fid, '%%%% Signal Analysis\n');
    fprintf(fid, '%% A condensed script version of the Signal Analysis GUI app.\n');
    fprintf(fid, '%% It allows users to rerun the code with the settings they inputted in the GUI.\n');
    fprintf(fid, '%% This is particularly useful if datasets are large and require supercomputer.\n');
    fprintf(fid, '%% It already contains everything necessary to be run by itself as a script.\n');

    fprintf(fid, 'close all; clc; clear; \n');
    fprintf(fid, "addpath(genpath('utility'))\n\n\n");
    
    fprintf(fid, '%%%% USER INPUTS\n');
    fprintf(fid, "disp('Reading user inputs');\n");
    fprintf(fid, "FolderPath = '%s';\n", folder_path);
    fprintf(fid, "FileNameNucCh = '%s';\n", filename_nuc);
    fprintf(fid, "FileNameCaCh = '%s';\n", filename_ca);
    fprintf(fid, "StartFrame = %i;\n", start_frame);
    fprintf(fid, "EndFrame = %i;\n", end_frame);
    fprintf(fid, "OutputFolder = '%s';\n", output_folder);
    fprintf(fid, "ExposureTime = %i; %% exposure time in milliseconds\n", exposure_time);
    fprintf(fid, "MeanDist = %f; %% frames per cycle\n", mean_dist);
    fprintf(fid, "Visibility = 'off'; %% display figures or note\n");
    fprintf(fid, "load([FolderPath, OutputFolder, '\\ROI_boundary.mat'])\n\n\n");
    
    fprintf(fid, '%%%% RUN CODE\n');
    fprintf(fid, "run_signal_analysis(FolderPath, FileNameNucCh, FileNameCaCh, ...\n");
    fprintf(fid, "    StartFrame, EndFrame, OutputFolder, ExposureTime, MeanDist, ...\n");
    fprintf(fid, "    Visibility, ROI_boundary);\n");
    
    fclose(fid);
end
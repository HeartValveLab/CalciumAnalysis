function save_signal_analysis(folder_path, filename_nuc, filename_ca, start_frame, end_frame, output_folder, exposure_time, mean_dist, ROI_boundary)
    %% Save settings
    folder_w = [folder_path, output_folder];
    fid = fopen([folder_w, '\SignalAnalysisSession_', datestr(now, 'ddmmyyyy_HHMMSS'), '.m'], 'wt' );
    fprintf(fid, '%%%% Signal Analysis\n');
    fprintf(fid, '%% This file contains user variables initialised during a GUI session.\n');
    fprintf(fid, '%% It already contains everything necessary to be run by itself as a script.\n');
    fprintf(fid, 'close all; clc; clear; \n');
    fprintf(fid, "addpath(genpath('utility'))\n\n\n");
    
    fprintf(fid, '%%%% USER INPUTS\n');
    fprintf(fid, "FolderPath = '%s';\n", folder_path);
    fprintf(fid, "FilenameCh1 = '%s';\n", FilenameCh1);
    fprintf(fid, "FilenameCh2 = '%s';   %% optional\n", FilenameCh2);
    fprintf(fid, "FilenameCh3 = '%s';   %% optional\n\n", FilenameCh3);
    
    fprintf(fid, "MainCh = %i; %% channel to be used for reference\n", MainCh);
    fprintf(fid, "Phase = %i;  %% frame to be used for reference\n\n", Phase);
    
    fprintf(fid, "NumScales = %i;\n", NumScales);
    fprintf(fid, "MinPeakHeight = %i;\n", MinPeakHeight);
    fprintf(fid, "MinPeakProminence = %i;\n\n", MinPeakProminence);
    
    fprintf(fid, "ROI = [%i, %i, %i, %i];     %% x_start, y_start, x_end, y_end\n", ROI);
    fprintf(fid, "Padding = %i;\n", Padding);
    fprintf(fid, "CheckNeighbours = %i;\n\n", CheckNeighbours);
    
    fprintf(fid, "OutputName = '%s';\n", OutputName);
    fprintf(fid, "Output = '010';\n\n");
    
    fprintf(fid, '%%%% RUN CODE\n');
    fprintf(fid, "phase_matching_script(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, ...\n");
    fprintf(fid, "    MainCh, Phase, NumScales, MinPeakHeight, MinPeakProminence, Padding, ...\n");
    fprintf(fid, "    ROI, CheckNeighbours, OutputName, Output);\n");
    
    fclose(fid);
end
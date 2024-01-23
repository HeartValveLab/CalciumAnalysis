function [file_paths, output_path, tif_info, n_frames, n_channels, end_frame] = initialise_signal_analysis(folder_path, filename_ref, filename_ch, start_frame, end_frame, output_folder);
% INITIALISE_SIGNAL_ANALYSIS takes in user input parameters and returns values that may be
% needed later on.
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2024-01-23
% ------INPUTS------
% folder_path (str):    Folder containing datasets
% filename_ref (str):   Filename containing phase matched reference data
% filename_ca (str):    Filename containing phase matched calcium data
% start_frame (str):    First frame of data to use
% end_frame (str):      Last frame of data to use
% output_folder (str):  Subfolder to create for storing outputs
% -----OUTPUTS-----
% file_paths (cell):    Full paths to input datasets
% output_path (str):    Full path to output folder
% tif_info (struct):    Metadata pertaining to input dataset
% n_frames (double):    Number of frames to be used for analysis
% end_frame (double):   Last frame of data to use
    file_paths = {
                strcat(folder_path, filename_ref), ...
                strcat(folder_path, filename_ch), ...
                };
    output_path = [folder_path, output_folder];
    mkdir(output_path);
    tif_info = imfinfo(file_paths{1});
    if end_frame == 0
        end_frame = length(tif_info);
    end
    n_frames = end_frame - start_frame + 1;
    n_channels = 2;
end
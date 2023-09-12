function [file_paths, n_channels, main_path, tif_info, img_ref] = initialise_phase_matching(folder_path, filename_1, filename_2, filename_3, main_ch, phase)
% INITIALISE_PHASE_MATCHING takes in user input parameters and returns values that may be
% needed later on.
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% folder_path (str):    Folder containing datasets
% filename_1 (str):     Filename for first channel
% filename_2 (str):     Filename for second channel
% filename_3 (str):     Filename for third channel
% main_ch (double):     Channel number to use as reference
% phase (double):       Frame to use as reference
% -----OUTPUTS-----
% file_paths (cell):    Full paths to input datasets
% n_channels (double):  Number of input channels used
% main_path (str):      Path to reference channel dataset
% tif_info (struct):    Metadata pertaining to input dataset
% img_ref (arr):        Reference image
    file_paths = {
                strcat(folder_path, filename_1), ...
                strcat(folder_path, filename_2), ...
                strcat(folder_path, filename_3)
                };
    n_channels = sum([ ...
                    ~isempty(filename_1), ...
                    ~isempty(filename_2), ...
                    ~isempty(filename_3) ...
                    ]);
    main_path = file_paths{main_ch};
    tif_info = imfinfo(main_path);
    img_ref = imread(main_path, phase);
end
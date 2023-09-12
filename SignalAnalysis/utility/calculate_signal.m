function signal = calculate_signal(start_frame,end_frame,file_path,ROI_boundary)
% CALCULATE_SIGNAL calculates the signal intensity for the ROI in each
% frame of a tif file
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% file_path (str):      Path to dataset
% start_frame (str):    First frame of data to use
% end_frame (str):      Last frame of data to use
% ROI_boundary (arr):   Logical array containing ROI drawn
% -----OUTPUTS-----
% signal (arr):         Intensity values for each frame
signal_tmp = [];
    for frame = start_frame:end_frame
        img = imread(file_path, frame);
        ROI_mean_intensity = regionprops(ROI_boundary, img, 'MeanIntensity');  
        signal_tmp = [signal_tmp, ROI_mean_intensity];
    end
    signal = [signal_tmp.MeanIntensity]';
end
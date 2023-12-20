function ssim_scores = ssim_wrapper(img_ref, tif_path, x_bounds, y_bounds, frame_idx, num_scales)
% SSIM_WRAPPER is a wrapper function for ssim. It checks the reference 
% image against all other images in the dataset and returns a set of
% similarity scores.
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-12-20
% ------INPUTS------
% img_ref (arr):        Reference image
% tif_path (str):       Path to dataset
% x_bounds (arr):       x coordinates of ROI
% y_bounds (arr):       y coordinates of ROI
% frame_idx (arr):      Frames from tif file to use
% num_scales (int):     Tuning parameter for multissim3 algorithm
% -----OUTPUTS-----
% ssim_scores (arr):    List of similarity scores
    ssim_scores = [];
    for i_frame = frame_idx
        img = imread(tif_path, i_frame);
        ssim_score = multissim3(img_ref(y_bounds,x_bounds), img(y_bounds,x_bounds), NumScales=num_scales);
        ssim_scores = [ssim_scores; ssim_score];
    end
end
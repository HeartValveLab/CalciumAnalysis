function [ssim_score_lst, n_frames] = pre_phase_matching(tif_info, main_path, img_ref, num_scales)
% PRE_PHASE_MATCHING checks the reference image against all other images in
% the dataset and returns a similarity score.
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% tif_info (struct):    Metadata pertaining to input dataset
% main_path (str):      Path to reference channel dataset
% img_ref (arr):        Reference image
% num_scales (double):  Adjustable parameter for ssim
% -----OUTPUTS-----
% ssim_score_lst (arr): List of similarity scores
% n_frames (double):    Number of frames in dataset
    n_frames = length(tif_info);
    ssim_score_lst = zeros(n_frames,1);
    for i_frame = 1:n_frames
        img_sug = imread(main_path, i_frame);
        ssim_score = multissim3(img_sug, img_ref, NumScales = num_scales);
        ssim_score_lst(i_frame) = ssim_score;
    end
end
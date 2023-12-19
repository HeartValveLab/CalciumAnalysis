function ssim_scores = spatial_phase_matching(input_data, input_params)
% SPATIAL_PHASE_MATCHING determines a ssim score based purely on spatial
% information in the dataset
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-12-19
% ------INPUTS------
% input_data (class):       Class structure containing input dataset
% input_params (class):     Class structure containing input variables
% -----OUTPUTS-----
% ssim_scores (arr):        List of similarity scores
    img_ref = input_data.get_img;
    ssim_scores = ssim_wrapper(img_ref, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
end
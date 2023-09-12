function ssim_vals = local_ssim(main_path, x_bounds, y_bounds, img_ref, sug_idx, n_neighbours)
% LOCAL_SSIM determines a more precise ssim for the region of interest and
% only compares to nearby neighbours
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% main_path (str):      Path to reference channel dataset
% x_bounds (arr):       x coordinates of ROI
% y_bounds (arr):       y coordinates of ROI
% img_ref (arr):        Reference image
% sug_idx (double):     Estimate of matching phase
% n_neighbours (double):Number of neighbours to check for phase match
% -----OUTPUTS-----
% ssim_vals (arr):      similarity scores for ROI in neighbours
    ssim_vals = zeros(1,2*n_neighbours+1);
    for offset = -n_neighbours:n_neighbours
        img_sug = imread(main_path, sug_idx+offset);
        ssim_sug = multissim3(img_sug(y_bounds,x_bounds), img_ref(y_bounds,x_bounds));
        ssim_vals(offset+n_neighbours+1) = ssim_sug;
    end
end
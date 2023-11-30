function [matched_frames, mean_dist] = best_neighbour_phase_matching(input_data, input_params, pk_locs)
% BEST_NEIGHBOUR_PHASE_MATCHING determines the phase matched frame based on
% the highest ssim for a region of interest
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-11-09
% ------INPUTS------
% input_data (class):       Class structure containing input dataset
% input_params (class):     Class structure containing input variables
% -----OUTPUTS-----
% pks (arr):                Value of ssim peaks
% matched_frames (arr):     Location of ssim peaks
% n_pks (arr):              Number of peaks found
% mean_dist (double):       Number of frames in a cardiac cycle
    matched_frames(1) = pk_locs(1);
    for i_pk = 1:length(pk_locs)
        if i_pk ~= 1
            frame_idx = pk_locs(i_pk)-input_params.n_neighbours : pk_locs(i_pk)+input_params.n_neighbours;
            ssim_vals = ssim_wrapper(input_data.get_img, input_data.main_path, input_params.x_bounds, input_params.y_bounds, frame_idx, input_params.n_scales);
            [max_ssim, max_ssim_loc] = max(ssim_vals);
            matched_frames(i_pk) = pk_locs(i_pk) + max_ssim_loc - input_params.n_neighbours - 1;
        end
    end
    mean_dist = mean(diff(matched_frames));
end
function [pks, matched_frames, n_pks, mean_dist, ssims_total] = temporal_phase_matching(input_data, input_params, mean_dist)
% TEMPORAL_PHASE_MATCHING utilises temporal data of neighbouring frames to
% better determine the phase matched frame.
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
    switch input_data.phase
        case 1
            img_ref = input_data.get_img;
            img_after = input_data.get_img(input_data.phase+1);
            ssims_main = ssim_wrapper(img_ref, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_after = ssim_wrapper(img_after, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_total = ssims_main(1:end-1) + 0.7*ssims_after(2:end);
            [pks, pk_locs, n_pks, mean_dist] = find_peaks_v2(ssims_total, input_params.min_peak_height, input_params.min_peak_prominence, 0.75*mean_dist, input_data.phase);
            matched_frames = pk_locs;
        case 2
            img_ref = input_data.get_img;
            img_before = input_data.get_img(input_data.phase-1);
            img_after = input_data.get_img(input_data.phase+1);
            ssims_main = ssim_wrapper(img_ref, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_before = ssim_wrapper(img_before, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_after = ssim_wrapper(img_after, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_total = 0.7*ssims_before(1:end-2) + ssims_main(2:end-1) + 0.7*ssims_after(3:end);
            ssims_total = [min(ssims_total); ssims_total];
            [pks, pk_locs, n_pks, mean_dist] = find_peaks_v2(ssims_total, input_params.min_peak_height, input_params.min_peak_prominence, 0.75*mean_dist, input_data.phase);
            matched_frames = pk_locs;
        otherwise 
            img_ref = input_data.get_img;
            img_before = input_data.get_img(input_data.phase-1);
            img_after = input_data.get_img(input_data.phase+1);
            ssims_main = ssim_wrapper(img_ref, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_before = ssim_wrapper(img_before, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_after = ssim_wrapper(img_after, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_total = 0.7*ssims_before(1:end-2) + ssims_main(2:end-1) + 0.7*ssims_after(3:end);
            ssims_total = [ssims_total(1); ssims_total];
            [pks, pk_locs, n_pks, mean_dist] = find_peaks_v2(ssims_total, input_params.min_peak_height, input_params.min_peak_prominence, 0.75*mean_dist, input_data.phase);
            matched_frames = pk_locs;
    end
end
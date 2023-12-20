function ssims_total = temporal_phase_matching(input_data, input_params)
% TEMPORAL_PHASE_MATCHING utilises temporal data of neighbouring frames to
% better determine the phase matched frame.
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-12-20
% ------INPUTS------
% input_data (class):       Class structure containing input dataset
% input_params (class):     Class structure containing input variables
% -----OUTPUTS-----
% ssim_total (arr):         List of similarity scores
    switch input_data.phase
        case 1
            img_ref = input_data.get_img;
            img_after = input_data.get_img(input_data.phase+1);
            ssims_main = ssim_wrapper(img_ref, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_after = ssim_wrapper(img_after, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_total = 0.6*ssims_main(1:end-1) + 0.4*ssims_after(2:end);
        otherwise 
            img_ref = input_data.get_img;
            img_before = input_data.get_img(input_data.phase-1);
            img_after = input_data.get_img(input_data.phase+1);
            ssims_main = ssim_wrapper(img_ref, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_before = ssim_wrapper(img_before, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_after = ssim_wrapper(img_after, input_data.main_path, input_params.x_bounds, input_params.y_bounds, 1:input_data.n_frames, input_params.n_scales);
            ssims_total = 0.25*ssims_before(1:end-2) + 0.5*ssims_main(2:end-1) + 0.25*ssims_after(3:end);
            ssims_total = [ssims_main(1); ssims_total];
    end
end
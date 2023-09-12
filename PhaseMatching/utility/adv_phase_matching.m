function images_to_save = adv_phase_matching(n_pks, main_path, x_bounds, y_bounds, img_ref, pk_locs, n_neighbours, cut_length, n_channels, tif_info, images_to_save, file_paths)
% ADV_PHASE_MATCHING targets specific regions for phase matching
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% n_pks (double):       Number of peaks found
% main_path (str):      Path to reference channel dataset
% x_bounds (arr):       x coordinates of ROI
% y_bounds (arr):       y coordinates of ROI
% img_ref (arr):        Reference image
% pk_locs (arr):        Location of peaks
% n_neighbours (double):Number of neighbours to check for phase matching
% cut_length (double):  Number of frames to keep on either side of peak
% n_channels (double):  Number of input channels used
% tif_info (struct):    Metadata pertaining to input dataset
% images_to_save (cell):Data object to save phase matched images
% file_paths (cell):    Full paths to input datasets
% -----OUTPUTS-----
% images_to_save (cell):Data object to save phase matched images
    ssim_offset = 0;
    for i_pks = 1:n_pks-1
        if i_pks~= 1
            ssim_vals = local_ssim(main_path, x_bounds, y_bounds, img_ref, pk_locs(i_pks), n_neighbours);
            [max_ssim, max_ssim_loc] = max(ssim_vals);
            ssim_offset = max_ssim_loc-n_neighbours-1;
        end
        phase = 0;
        for pad_offset = -cut_length: 1: cut_length
            phase = phase + 1;
            frame_idx = pk_locs(i_pks) + pad_offset + ssim_offset;
            for channel = 1:n_channels
                if frame_idx >= 1 && frame_idx <= length(tif_info)
                    images_to_save{channel, i_pks, phase} = imread(file_paths{channel}, frame_idx);
                else
                    images_to_save{channel, i_pks, phase} = zeros(tif_info(1).Height, tif_info(1).Width);
                end
            end
        end
    end
end
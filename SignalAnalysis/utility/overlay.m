function overlayed_image = overlay(file_path, tif_info, start_frame, end_frame, n_frames)
% OVERLAY takes a tif file and overlays the specified range of frames
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-09-12
% ------INPUTS------
% file_path (str):      Full path to dataset
% start_frame (str):    First frame of data to use
% end_frame (str):      Last frame of data to use
% n_frames (str):       Number of frames involved
% -----OUTPUTS-----
% overlayed_image (arr):Overlayed image
    overlayed_image = zeros(tif_info(1).Height, tif_info(1).Width);
    for frame = start_frame:end_frame
        img = imread(file_path, frame);
        overlayed_image = overlayed_image + double(img);
    end
    overlayed_image = uint8(overlayed_image/(n_frames));
end
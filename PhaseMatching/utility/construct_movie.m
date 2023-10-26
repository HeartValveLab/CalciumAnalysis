function movie_output = construct_movie(file_paths, movie_output, pks_locs, cut_length)
% CONSTRUCT_MOVE takes the location of the peaks and constructs the movie
% ready to be exported.
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-10-26
% ------INPUTS------
% file_paths (cell):    Full paths to input datasets
% pks_locs (arr):       List of peak locations
% cut_length (double):  Number of frames to keep on either side of peak
% -----OUTPUTS-----
% movie_output (cell):  Data object to save phase matched images
    tif_info = imfinfo(file_paths{1});
    for i_pk = 1:length(pks_locs)
        for channel = 1:length(file_paths)
            phase = 1;
            for pad_offset = -cut_length:1:cut_length
                frame_idx = pks_locs(i_pk) + pad_offset;
                if frame_idx >= 1 && frame_idx <= length(tif_info)
                    movie_output{channel, i_pk, phase} = imread(file_paths{channel}, frame_idx);
                else
                    movie_output{channel, i_pk, phase} = zeros(tif_info(1).Height, tif_info(1).Width);
                end
                phase = phase + 1;
            end
        end
    end
end
function [pks, pk_locs, n_pks, mean_dist] = update_peaks(cursor_info, pks, pk_locs)
% FIND_PEAKS finds the list of peaks from the similarity scores
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-12-20
% ------INPUTS------
% cursor_info (struct):     Position of points user selected in figure
% pks (arr):                Value of peaks
% pk_locs (arr):            Location of peaks
% n_pks (arr):              Number of peaks found
% mean_dist (double):       Average number of frames between peaks
% -----OUTPUTS-----
% pks (arr):                Value of peaks
% pk_locs (arr):            Location of peaks
% n_pks (arr):              Number of peaks found
% mean_dist (double):       Average number of frames between peaks
    for pt_idx = 1:length(cursor_info)
        frame = cursor_info(pt_idx).Position(1);
        if ismember(frame, pk_locs)     % remove if exists
            pk_idx = find(pk_locs==frame, 1);
            pk_locs(pk_idx) = [];
            pks(pk_idx) = [];
        else
            pk_locs = [pk_locs; frame];
            pks = [pks; cursor_info(pt_idx).Position(2)];
        end
    end
    [pk_locs, sortIdx] = sort(pk_locs);
    pks = pks(sortIdx);
    n_pks = length(pk_locs);
    mean_dist = mean(diff(pk_locs));
end
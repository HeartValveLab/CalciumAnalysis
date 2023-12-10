function [pks, pk_locs, n_pks, mean_dist] = find_peaks(ssim_score_lst, min_peak_height, min_peak_prom, min_peak_dist, phase)
% FIND_PEAKS finds the list of peaks from the similarity scores
% ------------------
% Author:   Raymond Zhang (Australian Regenerative Medicine Institute)
% Email:    raymond.zhang@monash.edu
% Updated:  2023-11-09
% ------INPUTS------
% ssim_score_lst (arr):     List of similarity scores
% min_peak_height (double): Adjustable parameter for findpeaks
% min_peak_prom (double):   Adjustable parameter for findpeaks
% phase (double):           Used to find first peak
% -----OUTPUTS-----
% pks (arr):                Value of peaks
% pk_locs (arr):            Location of peaks
% n_pks (arr):              Number of peaks found
% mean_dist (double):       Average number of frames between peaks
    [pks, pk_locs] = findpeaks(ssim_score_lst, ...
        MinPeakDistance = min_peak_dist, ...
        MinPeakHeight = min_peak_height, ...
        MinPeakProminence = min_peak_prom);
    if phase == 1
        pk_locs = [1; pk_locs];
        pks = [ssim_score_lst(1); pks];
    end
    n_pks = length(pk_locs);
    mean_dist = mean(diff(pk_locs));
end
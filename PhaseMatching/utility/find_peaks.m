function [pks, pk_locs, N_pks] = find_peaks(ssim_score_lst, MinPeakHeight, MinPeakProminence, Phase)
    [pks, pk_locs] = findpeaks(ssim_score_lst, ...
        MinPeakHeight = MinPeakHeight, ...
        MinPeakProminence = MinPeakProminence);
    N_pks = length(pk_locs);
    
    if Phase == 1
        pk_locs = [1; pk_locs];
        pks = [ssim_score_lst(1); pks];
    end
end
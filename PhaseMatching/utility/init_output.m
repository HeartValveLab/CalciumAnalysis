function [cutLength, ImagesToSave] = init_output(pk_locs, Padding, N_channels, N_pks)
distance_btwn_peaks = diff(pk_locs);
meanDist = mean(distance_btwn_peaks); %Average number of frames between peaks
cutLength = round(meanDist/2 + Padding);
ImagesToSave = cell(N_channels, N_pks,2*cutLength+1);
end
function ImagesToSave = adv_phase_matching(N_pks, pathnameChMain, xbounds, ybounds, Phase, pk_locs, n_neighbours, cutLength, N_channels, tifInfo, ImagesToSave, pathnames)
offset = 0;
for i = 1:N_pks-1
    if i~= 1
        ssim_vals = auto_correct(pathnameChMain, xbounds, ybounds, Phase, pk_locs(i), n_neighbours);
        [M_1, I_1] = max(ssim_vals);
        offset = I_1-n_neighbours-1;
    end
    k = 0;
    for j = -cutLength: 1: cutLength
        k = k + 1;
        frame_idx = pk_locs(i)+j+offset;
        for ch = 1:N_channels
            if frame_idx >= 1 && frame_idx <= length(tifInfo)
                ImagesToSave{ch, i, k} = imread(pathnames{ch}, frame_idx);
            else
                ImagesToSave{ch, i, k} = zeros(tifInfo(1).Height, tifInfo(1).Width);
            end
        end
    end
end
end
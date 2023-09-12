function run_phase_matching(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase, NumScales, MinPeakHeight, MinPeakProminence, Padding, ROI, CheckNeighbours, OutputName, Output)
    %% Initiation
    disp('Initiating inputs');
    
    [pathnames, N_channels, pathnameChMain, tifInfo, img_ref] = initialise_phase_matching(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase);
    % figure(1);
    % imshow(img_ref);
    % title('This is our reference image for phase matching')
    
    
    %% Preliminary Phase Matching
    disp('Performing preliminary phase matching');
    [ssim_score_lst, N] = pre_phase_matching(tifInfo, pathnameChMain, img_ref, NumScales);
    [pks, pk_locs, N_pks] = find_peaks(ssim_score_lst, MinPeakHeight, MinPeakProminence, Phase);
    mean_dist = mean(diff(pk_locs));
    
    figure(2);
    plot(1:N, ssim_score_lst); hold on;
    plot(pk_locs, pks, "*")
    title(['ssim scores. ', num2str(N_pks), ' peaks found at an average distance of ', num2str(mean_dist)])
    
    
    %% ROI Based Phase Matching
    disp('Performing advanced phase matching');
    [cutLength, ImagesToSave] = init_output(pk_locs, Padding, N_channels, N_pks);
    
    xbounds = ceil(ROI(1)):floor(ROI(1)+ROI(3));
    ybounds = ceil(ROI(2)):floor(ROI(2)+ROI(4));
    n_neighbours = CheckNeighbours;
    
    ImagesToSave = adv_phase_matching(N_pks, pathnameChMain, xbounds, ybounds, Phase, pk_locs, n_neighbours, cutLength, N_channels, tifInfo, ImagesToSave, pathnames);
    
    
    %% Output
    disp('Saving files');
    outputFolder = OutputName;
    outputFileName = OutputName;
    folder_w = [FolderPath, outputFolder];
    mkdir(folder_w);
    javaaddpath('loci_tools.jar')
    
    if Output(1) == '1'
        save_multitiff(N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w)
    end
    
    if Output(2) == '1'
        save_phase(tifInfo, N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w, Phase);
    end
    
    if Output(3) == '1'
        save_all(tifInfo, N_pks, N_channels, cutLength, ImagesToSave, outputFileName, folder_w);
    end
end
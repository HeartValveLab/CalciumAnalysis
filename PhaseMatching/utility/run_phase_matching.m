function run_phase_matching(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase, NumScales, MinPeakHeight, MinPeakProminence, Padding, ROI, CheckNeighbours, Visibility, OutputFolder, Output)
% RUN_PHASE_MATCHING is a header function to run all phase matching code
% cleanly

    % Initiation
    disp('Processing user inputs');
    [FilePaths, N_channels, MainPath, TifInfo, ImgRef] = initialise_phase_matching(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase);
    figure('Visible',Visibility);
    imshow(ImgRef);
    title('This is our reference image for phase matching')
    disp('User inputs processed')
    
    % Preliminary Phase Matching
    disp('Performing preliminary phase matching');
    [SsimScores, N_Frames] = pre_phase_matching(TifInfo, MainPath, ImgRef, NumScales);
    [Pks, PkLocs, N_pks, MeanDist] = find_peaks(SsimScores, MinPeakHeight, MinPeakProminence, Phase);
    
    figure('Visible',Visibility);
    plot(1:N_Frames, SsimScores); hold on;
    plot(PkLocs, Pks, "*")
    title(['ssim scores. ', num2str(N_pks), ' peaks found at an average distance of ', num2str(MeanDist)])
    disp('Preliminary phase matching complete')

    % ROI Based Phase Matching
    disp('Performing advanced phase matching');
    CutLength = round(MeanDist/2 + Padding);
    ImagesToSave = cell(N_channels, N_pks,2*CutLength+1);
    X_bounds = ceil(ROI(1)):floor(ROI(1)+ROI(3));
    Y_bounds = ceil(ROI(2)):floor(ROI(2)+ROI(4));
    N_neighbours = CheckNeighbours;
    ImagesToSave = adv_phase_matching(N_pks, MainPath, X_bounds, Y_bounds, ImgRef, PkLocs, N_neighbours, CutLength, N_channels, TifInfo, ImagesToSave, FilePaths);
    disp('Advanced phase matching complete')
    
    % Output
    disp('Saving files');
    OutputPath = [FolderPath, OutputFolder];
    mkdir(OutputPath);
    javaaddpath('loci_tools.jar')
    
    if Output(1) == '1'
        save_multitiff(N_pks, N_channels, CutLength, ImagesToSave, OutputPath)
    end
    
    if Output(2) == '1'
        save_single_phase(TifInfo, N_pks, N_channels, CutLength, ImagesToSave, OutputPath, Phase);
    end
    
    if Output(3) == '1'
        save_all_phase(TifInfo, N_pks, N_channels, CutLength, ImagesToSave, OutputPath);
    end
    disp('Files saved');
end
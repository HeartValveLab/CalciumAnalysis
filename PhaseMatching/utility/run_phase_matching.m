function run_phase_matching(InputData, InputParams, Visibility, OutputFolder, Output);
% RUN_PHASE_MATCHING is a header function to run all phase matching code
% cleanly

    % Initiation
    disp('Processing user inputs');
    ImgRef = InputData.get_img;
    figure('Visible',Visibility);
    imshow(ImgRef);
    title('This is our reference image for phase matching')
    disp('User inputs processed')
    
    % Preliminary Phase Matching
    disp('Performing preliminary phase matching');
    SsimScoresMain = ssim_wrapper(ImgRef, InputData.main_path, 1:InputData.width, 1:InputData.height, 1:InputData.n_frames, InputParams.n_scales);
    [Pks, PkLocs, N_pks, MeanDist] = find_peaks_v2(SsimScoresMain, InputParams.min_peak_height, InputParams.min_peak_prominence, 0, InputData.phase);
    
    figure('Visible',Visibility);
    plot(1:InputData.n_frames, SsimScoresMain); hold on;
    plot(PkLocs, Pks, "*")
    title(['ssim scores. ', num2str(N_pks), ' peaks found at an average distance of ', num2str(MeanDist)])
    disp('Preliminary phase matching complete')

    % ROI Based Phase Matching
    disp('Performing advanced phase matching');
    [Pks, MatchedFrames, N_pks, MeanDist, SsimsTotal] = temporal_phase_matching(InputData, InputParams, MeanDist);
    disp('Advanced phase matching complete');

    % Output
    CutLength = InputParams.cut_length(MeanDist);
    ImagesToSave = cell(InputData.n_channels, N_pks, 2*CutLength+1);
    ImagesToSave = construct_movie(InputData.file_paths, ImagesToSave, MatchedFrames, CutLength);

    disp('Saving files');
    OutputPath = [InputData.folder_path, OutputFolder];
    mkdir(OutputPath);
    javaaddpath('loci_tools.jar')
    
    if Output(1) == '1'
        save_multitiff(InputData, CutLength, ImagesToSave, N_pks, OutputPath)
    end
    if Output(2) == '1'
        save_single_phase(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
    end
    if Output(3) == '1'
        save_all_phase(InputData, CutLength, ImagesToSave, N_pks, OutputPath);
    end
    disp('Files saved');
end
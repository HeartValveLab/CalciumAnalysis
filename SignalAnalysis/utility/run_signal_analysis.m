function run_signal_analysis(FolderPath, FileNameRefCh, FileNameCaCh, StartFrame, EndFrame, OutputFolder, ExposureTime, MeanDist, Visibility, ROI_boundary, Normalisation)
% RUN_SIGNAL_ANALYSIS is a header function to run all signal analysis code
% cleanly

    % Initiation
    disp('Processing user inputs');
    [FilePaths, OutputPath, TifInfo, N_frames, N_channels, EndFrame] = initialise_signal_analysis( ...
        FolderPath, FileNameRefCh, FileNameCaCh, StartFrame, EndFrame, OutputFolder);
    disp('User inputs processed')
    
    % Get and save overlay
    disp('Overlaying movie frames')
    OverlayedRef = overlay(FilePaths{1}, TifInfo, StartFrame, EndFrame, N_frames);
    imwrite(OverlayedRef, [OutputPath, filesep, 'OverlayedRef.tif'], 'tif')
    OverlayedCa = overlay(FilePaths{2}, TifInfo, StartFrame, EndFrame, N_frames);
    imwrite(OverlayedCa, [OutputPath, filesep, 'OverlayedCa.tif'], 'tif')
    OverlayedImages = {OverlayedRef, OverlayedCa};
    FusedChannel = imfuse(mat2gray(OverlayedImages{1}), mat2gray(OverlayedImages{2}));
    imwrite(FusedChannel, [OutputPath, filesep, 'OverlayedBoth.tif'], 'tif')
    disp('Overlay complete')
     
    % Draw and create region of interest
    disp('Creating region of interest')
    RefOverlay = mat2gray(OverlayedImages{1});
    CaOverlay = mat2gray(OverlayedImages{2});
    fusedChannel = imfuse(CaOverlay, RefOverlay);
    save_ROI(fusedChannel, ROI_boundary, OutputPath)
    disp('Region of interest saved')
    
    % Calculate signal vs time
    disp('Calculating intensity signal for ROI')
    SignalRef = calculate_signal(StartFrame,EndFrame,FilePaths{1},ROI_boundary);
    SignalCa = calculate_signal(StartFrame,EndFrame,FilePaths{2},ROI_boundary);
    disp('Signal intensity calculated')
    
    % Plot Raw Signal
    disp('Plotting raw signal graph')
    plot_raw_signal(Visibility,SignalCa,SignalRef,N_frames,MeanDist,ExposureTime,OutputPath)
    disp('Raw signal graph plotted')
    
    % Normalise Calcium signal
    disp('Calculating and plotting normalised signal');
    switch Normalisation
        case 'Ref'
            Baseline = min(SignalCa./SignalRef);
            NormSignal = (SignalCa./SignalRef - Baseline)/(Baseline);
        case 'Ca'
            Baseline = min(SignalCa);
            NormSignal = (SignalCa - Baseline)/Baseline;
    end
    
    Baseline = min(SignalCa./SignalRef);
    NormSignal = (SignalCa./SignalRef - Baseline)/(Baseline);
    plot_normalised_signal(Visibility,NormSignal,N_frames,MeanDist,ExposureTime,OutputPath)
    disp('Normalised signal plotted');
    
    % Make graph movie
    disp('Creating graph movie');
    create_graph_movie('off',NormSignal,N_frames,MeanDist,ExposureTime,OutputPath)
    close all;
    disp('Graph movie created');
    
    % Analysis
    
    % Finishing remarks
    disp('Script finished running')

end
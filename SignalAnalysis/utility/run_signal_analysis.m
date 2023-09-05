function run_signal_analysis(FolderPath, FileNameNucCh, FileNameCaCh, StartFrame, EndFrame, OutputFolder, ExposureTime, MeanDist, Visibility, ROI_boundary)
%% Header function for signal analysis code to abstract away all functions

    %% Initiation
    disp('Processing user inputs');
    [FilePaths, OutputPath, TifInfo, N_frames, N_channels, EndFrame] = initialise( ...
        FolderPath, FileNameNucCh, FileNameCaCh, StartFrame, EndFrame, OutputFolder);
    disp('User inputs processed')
    
    
    %% Get and save overlay
    disp('Overlaying movie frames')
    OverlayedNuc = overlay(FilePaths{1}, TifInfo, StartFrame, EndFrame, N_frames);
    imwrite(OverlayedNuc, [OutputPath, filesep, 'OverlayedNuc.tif'], 'tif')
    OverlayedCa = overlay(FilePaths{2}, TifInfo, StartFrame, EndFrame, N_frames);
    imwrite(OverlayedCa, [OutputPath, filesep, 'OverlayedCa.tif'], 'tif')
    OverlayedImages = {OverlayedNuc, OverlayedCa};
    disp('Overlay complete')
    
    
    %% Draw and create region of interest
    disp('Creating region of interest')
    NucOverlay = mat2gray(OverlayedImages{1});
    CaOverlay = mat2gray(OverlayedImages{2});
    fusedChannel = imfuse(CaOverlay, NucOverlay);
    save_ROI(fusedChannel, ROI_boundary, OutputPath)
    disp('Region of interest saved')
    
    
    %% Calculate signal vs time
    disp('Calculating intensity signal for ROI')
    SignalNuc = calculate_signal(StartFrame,EndFrame,FilePaths{1},ROI_boundary);
    SignalCa = calculate_signal(StartFrame,EndFrame,FilePaths{2},ROI_boundary);
    disp('Signal intensity calculated')
    
    
    %% Plot Raw Signal
    disp('Plotting raw signal graph')
    plot_raw_signal(Visibility,SignalCa,SignalNuc,N_frames,MeanDist,ExposureTime,OutputPath)
    disp('Raw signal graph plotted')
    
    
    %% Normalise Calcium signal
    disp('Calculating and plotting normalised signal');
    Baseline = min(SignalCa./SignalNuc);
    NormSignalByBackground = (SignalCa./SignalNuc - Baseline)/(Baseline);
    plot_normalised_signal(Visibility,NormSignalByBackground,N_frames,MeanDist,ExposureTime,OutputPath)
    disp('Normalised signal plotted');
    
    
    %% Make graph movie
    disp('Creating graph movie');
    create_graph_movie('off',NormSignalByBackground,N_frames,MeanDist,ExposureTime,OutputPath)
    close all;
    disp('Graph movie created');
    
    
    %% Analysis
    
    
    %% Finishing remarks
    disp('Script finished running')


end
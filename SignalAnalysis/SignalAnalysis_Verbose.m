%% Signal Analysis
%  A script version of the Signal Analysis GUI app. It allows users run the
%  automatic version of the code when the dataset is large.
%
%  Author: Raymond Zhang
%  Created: 2023-08-07
%  Updated: 2024-01-23

close all; clc; clear;
addpath(genpath('utility'))


%% USERS INPUTS
disp('Reading user inputs');
FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
FileNameRefCh = 'z005-Nuc.tif';
FileNameCaCh = 'z005-Ca.tif';
StartFrame = 1;
EndFrame = 0;
OutputFolder = 'CaSignalVsTime';
ExposureTime = 25;  % exposure time millisecond
MeanDist = 13.1351;    % frames per cycle
DispChannel = 'Both';
Normalisation = 'Ref';      % or 'Ca'
visibility = 'on'; % display figures or not
disp('User inputs read');


%% Initiation
disp('Processing user inputs');
[FilePaths, OutputPath, TifInfo, N_frames, N_channels, EndFrame] = initialise_signal_analysis( ...
    FolderPath, FileNameRefCh, FileNameCaCh, StartFrame, EndFrame, OutputFolder);
disp('User inputs processed')


%% Get and save overlay
disp('Overlaying movie frames')
OverlayedRef = overlay(FilePaths{1}, TifInfo, StartFrame, EndFrame, N_frames);
imwrite(OverlayedRef, [OutputPath, filesep, 'OverlayedRef.tif'], 'tif')
OverlayedCa = overlay(FilePaths{2}, TifInfo, StartFrame, EndFrame, N_frames);
imwrite(OverlayedCa, [OutputPath, filesep, 'OverlayedCa.tif'], 'tif')
OverlayedImages = {OverlayedRef, OverlayedCa};
FusedChannel = imfuse(mat2gray(OverlayedImages{1}), mat2gray(OverlayedImages{2}));
imwrite(FusedChannel, [OutputPath, filesep, 'OverlayedBoth.tif'], 'tif')
disp('Overlay complete')


%% Draw and create region of interest
disp('Creating region of interest')
RefOverlay = mat2gray(OverlayedImages{1});
CaOverlay = mat2gray(OverlayedImages{2});
FusedChannel = imfuse(RefOverlay, CaOverlay);

switch DispChannel
    case 'Both'
        Disp = FusedChannel;
    case 'Ca'
        Disp = CaOverlay;
    case 'Ref'
        Disp = RefOverlay;
end

switch visibility
    case 'on'
        imshow(Disp)
        axis on;
        title('Do not close this figure window till end of script!', 'FontSize', 16);
        message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
        uiwait(msgbox(message));
        hFH = imfreehand();
        ROI_boundary = hFH.createMask();
        save([OutputPath, filesep, 'ROI_boundary.mat'],"ROI_boundary")
        close();
    case 'off'       
        load([FolderPath, OutputFolder, '\ROI_boundary.mat'])
end

save_ROI(FusedChannel, ROI_boundary, OutputPath)
disp('Region of interest saved')


%% Calculate signal vs time
disp('Calculating intensity signal for ROI')
SignalRef = calculate_signal(StartFrame,EndFrame,FilePaths{1},ROI_boundary);
SignalCa = calculate_signal(StartFrame,EndFrame,FilePaths{2},ROI_boundary);
disp('Signal intensity calculated')


%% Plot Raw Signal
disp('Plotting raw signal graph')

figure('Visible',visibility);
hold on
plot(0:1:(N_frames-1)*1, SignalCa, 'g');
plot(0:1:(N_frames-1)*1, SignalRef, 'm');
title('Raw signal - cycles')
xlabel('Time [cycles]');
ylabel('Signal Intensity');
legend('CaSignal','RefSignal')
imageName = fullfile(OutputPath,'Raw Calcium and Reference Signal - cycles');
saveas(gcf,imageName,'tiff');

figure('Visible',visibility);
hold on
frame_scale = MeanDist; % plot according to number of actual frames
plot(0:frame_scale:(N_frames-1)*frame_scale, SignalCa, 'g');
plot(0:frame_scale:(N_frames-1)*frame_scale, SignalRef, 'm');
title('Raw signal - frames')
xlabel('Time [frames]');
ylabel('Signal Intensity');
legend('CaSignal','RefSignal')
imageName = fullfile(OutputPath,'Raw Calcium and Reference Signal - frames');
saveas(gcf,imageName,'tiff');

figure('Visible',visibility);
hold on
time_scale = MeanDist*ExposureTime/1000; % plot according to real time
plot(0:time_scale:(N_frames-1)*time_scale, SignalCa, 'g');
plot(0:time_scale:(N_frames-1)*time_scale, SignalRef, 'm');
title('Raw signal - time')
xlabel('Time [s]');
ylabel('Signal Intensity');
legend('CaSignal','RefSignal')
imageName = fullfile(OutputPath,'Raw Calcium and Reference Signal - seconds');
saveas(gcf,imageName,'tiff');

disp('Raw signal graph plotted')


%% Normalise Calcium signal
disp('Calculating and plotting normalised signal');
switch Normalisation
    case 'Ref'
        Baseline = min(SignalCa./SignalRef);
        NormSignal = (SignalCa./SignalRef - Baseline)/(Baseline);
    case 'Ca'
        Baseline = min(SignalCa);
        NormSignal = (SignalCa - Baseline)/Baseline;
end

figure('Visible',visibility);
hold on
plot(0:1:(N_frames-1)*1, NormSignal, 'k');
title('Normalised calcium signal - cycles')
xlabel('Time [cycles]');
ylabel('Signal Intensity');
imageName = fullfile(OutputPath,'Normalised Calcium Signal - cycles');
saveas(gcf,imageName,'tiff');

figure('Visible',visibility);
hold on
frame_scale = MeanDist; % plot according to number of actual frames
plot(0:frame_scale:(N_frames-1)*frame_scale, NormSignal, 'k');
title('Normalised calcium signal - frames')
xlabel('Time [frames]');
ylabel('Signal Intensity');
imageName = fullfile(OutputPath,'Normalised Calcium Signal - frames');
saveas(gcf,imageName,'tiff');

figure('Visible',visibility);
hold on
time_scale = MeanDist*ExposureTime/1000; % plot according to real time
plot(0:time_scale:(N_frames-1)*time_scale, NormSignal, 'k');
title('Normalised calcium signal - time')
xlabel('Time [s]');
ylabel('Signal Intensity');
imageName = fullfile(OutputPath,'Normalised Calcium Signal - seconds');
saveas(gcf,imageName,'tiff');

disp('Normalised signal plotted');


%% Make graph movie
disp('Creating graph movie');
GraphMoviePath = [OutputPath,'\GraphMovie'];
mkdir(GraphMoviePath);

for i = 1:N_frames
    figure('Visible','off')
    time_scale = MeanDist*ExposureTime/1000; % plot according to real time
    plot(0:time_scale:(i-1)*time_scale, NormSignal(1:i), 'k');
    title('Normalised Calcium Signal')
    xlabel('Time [s]');
    ylabel('Signal Intensity');
    axis([0,N_frames*time_scale,0,max(NormSignal)]);
    iName = string(i);
    imageName = fullfile(GraphMoviePath,iName);
    saveas(gcf,imageName,'tiff');
end
close all;
disp('Graph movie created');


%% Analysis


%% Finishing remarks
disp('Script finished running')


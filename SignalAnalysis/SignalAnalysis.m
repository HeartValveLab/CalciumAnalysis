%% Signal Analysis
%  A script version of the Signal Analysis GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-08-07
%  Updated: 2023-08-07

close all; clc; clear;
addpath(genpath('utility'))

%% USERS INPUTS
disp('Initialising inputs');

FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\PhaseMatching\data\CardiacCycle\';
FilenameCh1 = 'z005-Nuc.tif';
FilenameCh2 = 'z005-Ca.tif';    % optional
FilenameCh3 = '';               % optional

outputFolder = 'CaSignalVsTime';
folder_w=[FolderPath,outputFolder];
mkdir (folder_w);

MainCh = 1; % channel to be used for reference, not required
Phase = 1;  % frame to be used for reference, not required

samplingRate = 20;  % exposure time millisecond
meanDist = 14.4;    % frames per cycle
startImage = 1;

%% Initiation
disp('Processing inputs');
[pathnames, N_channels, pathnameChMain, tifInfo, img_ref] = initialise(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase);

%% Get and save overlay
disp('Overlaying movie')
N = length(tifInfo);
ImagesToSave = cell(1,N_channels);

for ch = 1:N_channels
    ImagesToSave{ch} = zeros(tifInfo(1).Height, tifInfo(1).Width);
    for frame = 1:N
        img = imread(pathnames{ch}, frame);
        ImagesToSave{ch} = ImagesToSave{ch} + double(img);
    end
    ImagesToSave{ch} = uint8(ImagesToSave{ch}/N);
    %imshow(ImagesToSave{ch})
    ImageFile = ['Channel', num2str(ch), '_overlay.tif'];
    imwrite(ImagesToSave{ch}, [FolderPath,filesep,ImageFile], 'tif')
end


%% Draw and create region of interest
disp('Performing signal analysis')
CaOverlay = mat2gray(ImagesToSave{2});

% Draw and create region of interest
imshow(CaOverlay,[])
axis on;
title('Do not close this figure window till end of script!', 'FontSize', 16);
set(gcf, 'Position', get(0,'Screensize')); 
message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = imfreehand(); % drawrectangle
binaryImage = hFH.createMask();
xy = hFH.getPosition;

% Save region of interest image
figure;
imshow(CaOverlay);
hold on;
boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
    thisBoundary = boundaries{k};
    plot(thisBoundary(:,2), thisBoundary(:,1), 'y', 'LineWidth', 1);
end
hold off;
imageName = fullfile(folder_w,'ROI');
saveas(gcf,imageName,'tiff');

%% Calculate signal vs time
SignalTemp = cell(1,N_channels);
Signal = cell(1,N_channels);
for ch = 1:N_channels
    for frame = startImage:N
        img = imread(pathnames{ch}, frame);
        ROI_mean_intensity = regionprops(binaryImage, img, 'MeanIntensity');  
        SignalTemp{ch} = [SignalTemp{ch}, ROI_mean_intensity];
    end
    Signal{ch} = [SignalTemp{ch}.MeanIntensity]';
end

NucSignal = Signal{1};
CaSignal = Signal{2};


%% Plot graph
xaxisScale = meanDist*samplingRate; % time in (ms) 
xaxisScale2 = meanDist;  % time in (# movie frames)

figure
plot(0:xaxisScale:(N-1)*xaxisScale, CaSignal, 'g');
hold on
plot(0:xaxisScale:(N-1)*xaxisScale, NucSignal, 'm');
xlabel('time (ms)');
ylabel('Calcium signal and Nuclear signal');
legend('CaSignal','NucSignal')
imageName = fullfile(folder_w,'Calcium and Nuclear Signal');
saveas(gcf,imageName,'tiff');

figure
plot(0:xaxisScale2:(N-1)*xaxisScale2, CaSignal, 'g');
hold on
plot(0:xaxisScale2:(N-1)*xaxisScale2, NucSignal, 'm');
xlabel('time (frames)');
ylabel('Calcium signal and Nuclear signal');
imageName = fullfile(folder_w,'Calcium and Nuclear Signal 2');
saveas(gcf,imageName,'tiff');

figure
plot(0:1:(N-1)*1, CaSignal, 'g');
hold on
plot(0:1:(N-1)*1, NucSignal, 'm');
xlabel('time (frames in SelectedT movie)');
ylabel('Calcium signal and Nuclear signal');
imageName = fullfile(folder_w,'Calcium and Nuclear Signal 3');
saveas(gcf,imageName,'tiff');

%% Normalise to background Ca level and Nuc
Baseline = min(CaSignal./NucSignal);
NormSignalByBackground = (CaSignal./NucSignal - Baseline)/(Baseline);

figure
plot(0:xaxisScale:(N-1)*xaxisScale, NormSignalByBackground, 'k');
xlabel('time (ms)');
ylabel('Normalised Calcium Signal');
imageName = fullfile(folder_w,'Normalised to baseline');
saveas(gcf,imageName,'tiff');

figure
plot(0:xaxisScale2:(N-1)*xaxisScale2, NormSignalByBackground, 'k');
xlabel('time (frames)');
ylabel('Normalised Calcium Signal');
imageName = fullfile(folder_w,'Normalised to baseline 2');
saveas(gcf,imageName,'tiff');

figure
plot(0:1:(N-1)*1, NormSignalByBackground, 'k');
xlabel('time (frames in SelectedT movie)');
ylabel('Normalised Calcium Signal');
imageName = fullfile(folder_w,'Normalised to baseline 3');
saveas(gcf,imageName,'tiff');

% Make graph movie
outputFolder2 = '\GraphMovie';
folder_mov=[folder_w,outputFolder2];
mkdir (folder_mov);
for i = 1:length(NormSignalByBackground)
    
figure
plot(0:xaxisScale:xaxisScale*(i-1), NormSignalByBackground(1:i), 'k');
xlabel('time (ms)');
ylabel('Normalised Calcium Signal');
axis([0,4*10^4,0,max(NormSignalByBackground)]);
iName = string(i);
imageName = fullfile(folder_mov,iName)
saveas(gcf,imageName,'tiff');

end

close all
%% Signal Analysis
%  A script version of the Signal Analysis GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-08-07
%  Updated: 2023-08-22

close all; clc; clear;
addpath(genpath('utility'))

%% USERS INPUTS
disp('Initialising inputs');

FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
FileNameNucCh = 'z005-Nuc.tif';
FileNameCaCh = 'z005-Ca.tif';
StartFrame = 1;
EndFrame = 37;

OutputFolder = 'CaSignalVsTime';


MainCh = 1; % channel to be used for reference, not required
Phase = 1;  % frame to be used for reference, not required

samplingRate = 20;  % exposure time millisecond
meanDist = 13.1351;    % frames per cycle


%% Initiation
disp('Initiating user inputs');
[FilePaths, OutputPath, TifInfo, N_frames, N_channels, EndFrame] = initialise(FolderPath, FileNameNucCh, FileNameCaCh, StartFrame, EndFrame, OutputFolder);
disp('User inputs accepted')

%% Get and save overlay
disp('Overlaying movie frames')
OverlayedNuc = overlay(FilePaths{1}, TifInfo, StartFrame, EndFrame, N_frames);
imwrite(OverlayedNuc, [OutputPath, filesep, 'OverlayedNuc.tif'], 'tif')
OverlayedCa = overlay(FilePaths{2}, TifInfo, StartFrame, EndFrame, N_frames);
imwrite(OverlayedCa, [OutputPath, filesep, 'OverlayedCa.tif'], 'tif')
OverlayedImages = {OverlayedNuc, OverlayedCa};
disp('Overlay complete')

%% Draw and create region of interest
disp('Performing signal analysis')
NucOverlay = mat2gray(OverlayedImages{1});
CaOverlay = mat2gray(OverlayedImages{2});
fusedChannel = imfuse(CaOverlay, NucOverlay);

% Draw and create region of interest
%imshow(CaOverlay,[])
imshow(fusedChannel)
axis on;
title('Do not close this figure window till end of script!', 'FontSize', 16);
%set(gcf, 'Position', get(0,'Screensize')); % Sets image to full screen
message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = imfreehand(); % drawrectangle
binaryImage = hFH.createMask();
save("test.mat","binaryImage")
xy = hFH.getPosition;
%close(1);

fid = fopen([OutputPath, '\PhaseMatchingSession_', datestr(now, 'ddmmyyyy_HHMMSS'), '.m'], 'wt' );
fprintf(fid, [repmat('%d\t', 1, size(binaryImage, 2)) '\n'], binaryImage');
fclose(fid);

% Save region of interest image
% figure;
% imshow(fusedChannel);
% hold on;
% boundaries = bwboundaries(binaryImage);
% numberOfBoundaries = size(boundaries, 1);
% for k = 1 : numberOfBoundaries
%     thisBoundary = boundaries{k};
%     plot(thisBoundary(:,2), thisBoundary(:,1), 'y', 'LineWidth', 1);
% end
% hold off;
% imageName = fullfile(folder_w,'ROI');
% saveas(gcf,imageName,'tiff');

%% Calculate signal vs time
SignalTemp = cell(1,N_channels);
Signal = cell(1,N_channels);
for ch = 1:N_channels
    for frame = StartFrame:EndFrame
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

% figure
% plot(0:xaxisScale:(N-1)*xaxisScale, CaSignal, 'g');
% hold on
% plot(0:xaxisScale:(N-1)*xaxisScale, NucSignal, 'm');
% xlabel('time (ms)');
% ylabel('Calcium signal and Nuclear signal');
% legend('CaSignal','NucSignal')
% imageName = fullfile(folder_w,'Calcium and Nuclear Signal');
% saveas(gcf,imageName,'tiff');
% 
% figure
% plot(0:xaxisScale2:(N-1)*xaxisScale2, CaSignal, 'g');
% hold on
% plot(0:xaxisScale2:(N-1)*xaxisScale2, NucSignal, 'm');
% xlabel('time (frames)');
% ylabel('Calcium signal and Nuclear signal');
% legend('CaSignal','NucSignal')
% imageName = fullfile(folder_w,'Calcium and Nuclear Signal 2');
% saveas(gcf,imageName,'tiff');

figure
plot(0:1:(N-1)*1, CaSignal, 'g');
hold on
plot(0:1:(N-1)*1, NucSignal, 'm');
xlabel('time (frames in SelectedT movie)');
ylabel('Calcium signal and Nuclear signal');
legend('CaSignal','NucSignal')
imageName = fullfile(folder_w,'Calcium and Nuclear Signal 3');
saveas(gcf,imageName,'tiff');

%% Normalise to background Ca level and Nuc
Baseline = min(CaSignal./NucSignal);
NormSignalByBackground = (CaSignal./NucSignal - Baseline)/(Baseline);

% figure
% plot(0:xaxisScale:(N-1)*xaxisScale, NormSignalByBackground, 'k');
% xlabel('time (ms)');
% ylabel('Normalised Calcium Signal');
% imageName = fullfile(folder_w,'Normalised to baseline');
% saveas(gcf,imageName,'tiff');
% 
% figure
% plot(0:xaxisScale2:(N-1)*xaxisScale2, NormSignalByBackground, 'k');
% xlabel('time (frames)');
% ylabel('Normalised Calcium Signal');
% imageName = fullfile(folder_w,'Normalised to baseline 2');
% saveas(gcf,imageName,'tiff');

figure
plot(0:1:(N-1)*1, NormSignalByBackground, 'k');
xlabel('time (frames in SelectedT movie)');
ylabel('Normalised Calcium Signal');
imageName = fullfile(folder_w,'Normalised to baseline 3');
saveas(gcf,imageName,'tiff');

% Make graph movie
% outputFolder2 = '\GraphMovie';
% folder_mov=[folder_w,outputFolder2];
% mkdir (folder_mov);
% for i = 1:length(NormSignalByBackground)
%     
% figure
% plot(0:xaxisScale:xaxisScale*(i-1), NormSignalByBackground(1:i), 'k');
% xlabel('time (ms)');
% ylabel('Normalised Calcium Signal');
% axis([0,4*10^4,0,max(NormSignalByBackground)]);
% iName = string(i);
% imageName = fullfile(folder_mov,iName);
% saveas(gcf,imageName,'tiff');
% 
% end

%close(1)

%% Analysis
% Z = ct_pulseanalysis(NormSignalByBackground','TSAMP',14.4,'MAXW',5);
% 
% Ztime = Z;
% Ztime.pkpos = Ztime.pkpos * (meanDist * samplingRate);
% Ztime.mpos = Ztime.mpos * (meanDist * samplingRate);
% Ztime.rise = Ztime.rise * (meanDist * samplingRate);
% Ztime.fall = Ztime.fall * (meanDist * samplingRate);
% Ztime.dur = Ztime.dur * (meanDist * samplingRate);
% 
% figure
% plot(0:xaxisScale:(N-1)*xaxisScale, NormSignalByBackground, 'k');
% xlabel('time (ms)');
% ylabel('Normalised Calcium Signal');
% imageName = fullfile(folder_w,'Peak Positions');
% hold on
% 
% for i = 1:length(Z.pkpos)
%     line([Z.pkpos(i),Z.pkpos(i)],[0,0.5],'Color','r','LineWidth',1); 
% end
% text(Z.pkpos,Z.peak+0.02,num2str((1:numel(Z.pkpos))'),'Color','r') 

%saveas(gcf,imageName,'tiff');

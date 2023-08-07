%% These following sections require the USER to input variables

% 1) Enter details of where to find/save images, image properties
% 2) Enter time scale based on length of cardiac cycle
% 3) Method 2 - Draw ROI by hand: Need to draw ROI

%%
close all
clear all

%% Enter details of where to find images, where to save outputs, and image details


FolderPath = 'C:\Users\rzha0171\Documents\UROP\UltimateTiff\PhaseMatchingOutput\';
%remember to include \ at end of FolderPath
filenameCaCh = 'PhaseMatchingOutput_Ca.tif';
filenameNucCh = 'PhaseMatchingOutput_Nuc.tif';
filenameOverlay = 'CaOverlay.tif';

pathnameNucCh = fullfile(FolderPath,filenameNucCh);
pathnameCaCh = fullfile(FolderPath,filenameCaCh);
pathnameOverlay = fullfile(FolderPath, filenameOverlay);

outputFolder = 'CaSignalVsTime';
folder_w=[FolderPath,outputFolder];
mkdir (folder_w);

N = 37; %Number of images (cardiac cycles)
startImage = 1;
samplingRate = 20; %exposure time on spinning disk. Value in milliseconds

%% Enter time scale based on length of cardiac cycle

meanDist = 14.4; % value taken from GetCardiacCycleFrame

%% Select ROI and save image as a record

%% Method 1 - Manually input coordinates for rectangular ROI
if 1 == 0
    
    ystart = 159;
    yend = 169; 
    xstart = 133;
    xend = 143;


    %check ROI to see if it looks right
 C = imread(pathnameCaCh, floor(N/2));
 C = imadjust(C);
 imshow(C);
 hold on
 title('Check ROI', 'FontSize', 16);
 set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
 rectangle('Position',[xstart,ystart,xend-xstart,yend-ystart],...
          'EdgeColor', 'r',...
          'LineWidth',1,'LineStyle','-');
 imageName = fullfile(folder_w,'ROI');
 saveas(gcf,imageName,'tiff');

 % Calculate signal vs time

 CaSignal = [];
 NucSignal = [];
 NormSignal = [];

 for i = startImage:N
    % Open image
    A = imread(pathnameCaCh, i);
    B = imread(pathnameNucCh,i);
    ROI_A = A(ystart:yend, xstart:xend);
    ROI_B = B(ystart:yend, xstart:xend);

    % Calculate total intensity
    S_A = sum(ROI_A);
    S_B = sum(ROI_B);
    Mean_all_A = sum(S_A)/((yend-ystart)*(xend-xstart));
    Mean_all_B = sum(S_B)/((yend-ystart)*(xend-xstart));    
   
    CaSignal = [CaSignal, Mean_all_A];
    NucSignal = [NucSignal, Mean_all_B];

 end

 CaSignal = CaSignal';
 NucSignal = NucSignal';

end

%% Method 2 - Draw ROI by hand

%if 1 == 1
    
 B = imread(pathnameOverlay);
 B1 = mat2gray(B);
 
 imshow(B1, []);
 axis on;
 title('Do not close this figure window till end of script!', 'FontSize', 16);
 set(gcf, 'Position', get(0,'Screensize')); 
 % Maximize figure. DO NOT DOCK OR CLOSE FIGURE.
 
 message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
 uiwait(msgbox(message));
 hFH = imfreehand(); % drawrectangle
 
 % Create a binary image ("mask") from the ROI object.
 binaryImage = hFH.createMask();
 xy = hFH.getPosition;
 %%
  figure;
  imshow(B1);
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

 CaSignalTemp = [];
 NucSignalTemp = [];

 for i = startImage:N
    % Open image
    A = imread(pathnameCaCh, i);
    B = imread(pathnameNucCh,i);

    % Calculate total intensity
    Mean_all_A = regionprops(binaryImage, A, ...
    'MeanIntensity');    
    Mean_all_B = regionprops(binaryImage, B, ...
    'MeanIntensity');  
   
    CaSignalTemp = [CaSignalTemp, Mean_all_A];
    NucSignalTemp = [NucSignalTemp, Mean_all_B];

 end

 CaSignal = [CaSignalTemp.MeanIntensity]';
 NucSignal = [NucSignalTemp.MeanIntensity]';

%end


%% Plot graph

xaxisScale = meanDist*samplingRate; % time in (ms) 
xaxisScale2 = meanDist;  % time in (# movie frames)

figure
plot(0:xaxisScale:(N-1)*xaxisScale, CaSignal, 'g');
hold on
plot(0:xaxisScale:(N-1)*xaxisScale, NucSignal, 'm');
xlabel('time (ms)');
ylabel('Calcium signal and Nuclear signal');
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
%% Normalise to background calcium level and flk nuclear signal

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

%% Make graph movie
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

%% Make graph with area under curve shaded

figure
plot(0:xaxisScale:(N-1)*xaxisScale, NormSignalByBackground, 'k');
H=area(0:xaxisScale:(N-1)*xaxisScale,NormSignalByBackground);
set(H(1),'FaceColor',[0.7 1 0.7]);
xlabel('time (ms)');
ylabel('Normalised Calcium Signal');
imageName = fullfile(folder_w,'Normalised to baseline shaded');
saveas(gcf,imageName,'tiff');

%% Analysis

%default ct_pulseanalysis has no SMOOTH parameter. Here it is set to 5.

Z = ct_pulseanalysis(NormSignalByBackground','TSAMP',14.4,'MAXW',5);

Ztime = Z;
Ztime.pkpos = Ztime.pkpos * (meanDist * samplingRate);
Ztime.mpos = Ztime.mpos * (meanDist * samplingRate);
Ztime.rise = Ztime.rise * (meanDist * samplingRate);
Ztime.fall = Ztime.fall * (meanDist * samplingRate);
Ztime.dur = Ztime.dur * (meanDist * samplingRate);

figure
plot(0:xaxisScale:(N-1)*xaxisScale, NormSignalByBackground, 'k');
xlabel('time (ms)');
ylabel('Normalised Calcium Signal');
imageName = fullfile(folder_w,'Peak Positions');
hold on

 for i = 1:length(Z.pkpos)
  line([Z.pkpos(i),Z.pkpos(i)],[0,0.5],'Color','r','LineWidth',1); 
 end
 text(Z.pkpos,Z.peak+0.02,num2str((1:numel(Z.pkpos))'),'Color','r') 

 saveas(gcf,imageName,'tiff');
 
%% Fourier transform

T = meanDist * samplingRate *10^-3;
Fs = 1/T;
L = N*T;
t = 1;

Y = fft(NormSignalByBackground); %Y = Fourier transform of normalised signal
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure

f = Fs * (0:(L/2))/L;
plot(f,P1)
xlabel('frequency (Hz)')
ylabel('|Normalised Calcium Signal(f)|')

[pks,locs] = findpeaks(P1,f,'SortStr','descend');
findpeaks(P1,f)
text(locs(1:3)+.02,pks(1:3),num2str(pks(1:3)))
OneTemp = ones(1,length(locs));
period = OneTemp./locs;
text(locs(1:3)+.02,pks(1:3)+0.1,num2str(period(1:3)'),'color','r')
xlabel('frequency (Hz)')
ylabel('|Normalised Calcium Signal(f)|')

imageName = fullfile(folder_w,'Fourier Transform');
saveas(gcf,imageName,'tiff');
%% Saving variables

f = fullfile(folder_w,'NormSignalByBackground.mat'); 
save(f,'NormSignalByBackground');

save 'allVariables_HajimeCalciumSignalVsTime12';
filename = 'allVariables_HajimeCalciumSignalVsTime12';
allfiles = dir(pwd);
FilesTomove = {allfiles(strncmp({allfiles.name},filename,length(filename))).name};
for i = 1:length(FilesTomove)
    movefile(FilesTomove{i},folder_w);
end


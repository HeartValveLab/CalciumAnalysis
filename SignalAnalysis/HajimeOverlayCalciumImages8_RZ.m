%% These following sections require the USER to input variables

% 1) Enter details of where to find/save images, image properties
 
%%
clear all
close all

%% 1) Enter details of where to find/save images, image properties


FolderPath = 'C:\Users\rzha0171\Documents\UROP\UltimateTiff\PhaseMatchingOutput\';
filenameCaCh = 'PhaseMatchingOutput_Ca.tif';
filenameNucCh = 'PhaseMatchingOutput_Nuc.tif';

pathnameNucCh = fullfile(FolderPath,filenameNucCh);
pathnameCaCh = fullfile(FolderPath,filenameCaCh);


N = 338; % enter number of frames in movie to analyse

%%

A_Nuc = imread(pathnameNucCh, 1);
A_Ca = imread(pathnameCaCh, 1);
C_Nuc = double(A_Nuc);
C_Ca = double(A_Ca);
    

for i = 2:N 
    % Open image
    A_Nuc = imread(pathnameNucCh, i);
    A_Ca = imread(pathnameCaCh, i);
    C_Nuc = C_Nuc + double(A_Nuc);
    C_Ca = C_Ca + double(A_Ca);
end

    CaOverlay = uint8(C_Ca/N);
    NucOverlay = uint8(C_Nuc/N);

%% Displaying output images
if 1 == 1
figure
AutoContrastedIm = C_Ca; 
AutoContrastedIm = imadjust(AutoContrastedIm);
imshow(AutoContrastedIm);
title('Calcium Overlay', 'FontSize', 16);

figure
AutoContrastedIm = C_Nuc; 
AutoContrastedIm = imadjust(AutoContrastedIm);
imshow(AutoContrastedIm);
title('Nuclear Overlay', 'FontSize', 16);
end
%% Saving images

outputFolder = 'CalciumOverlay';
outputFileNameCa = 'CaOverlay';
outputFileNameNuc = 'NucOverlay';
outputFileNameCaNuc = 'CaNucOverlay';

folder_w=[FolderPath,outputFolder];
mkdir (folder_w);

ImageFile=[outputFileNameCa '.tif'];
imwrite(CaOverlay, [folder_w,filesep,ImageFile],'tif')

ImageFile=[outputFileNameNuc '.tif'];
imwrite(NucOverlay, [folder_w,filesep,ImageFile],'tif')

%% Saving variables

save 'allVariables_OverlayCalciumImages8';
filename = 'allVariables_OverlayCalciumImages8';
allfiles = dir(pwd);
FilesTomove = {allfiles(strncmp({allfiles.name},filename,length(filename))).name};
for i = 1:length(FilesTomove)
    movefile(FilesTomove{i},folder_w);
end
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

MainCh = 1; % channel to be used for reference
Phase = 1;  % frame to be used for reference

%% Initiation
disp('Processing inputs');
[pathnames, N_channels, pathnameChMain, tifInfo, img_ref] = initialise(FolderPath, FilenameCh1, FilenameCh2, FilenameCh3, MainCh, Phase);

%% Get and save overlay
N = length(tifInfo);
ImagesToSave = cell(1,N_channels);

for ch = 1:N_channels
    ImagesToSave{ch} = zeros(tifInfo(1).Height, tifInfo(1).Width);
    for frame = 1:N
        img = imread(pathnames{ch}, frame);
        ImagesToSave{ch} = ImagesToSave{ch} + double(img);
    end
    ImagesToSave{ch} = uint8(ImagesToSave{ch}/N);
    imshow(ImagesToSave{ch})
    ImageFile = ['Channel', num2str(ch), '_overlay.tif'];
    imwrite(ImagesToSave{ch}, [FolderPath,filesep,ImageFile], 'tif')
end


%% Save overlay

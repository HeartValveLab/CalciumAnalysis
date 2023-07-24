%% Phase Matching
%  A script version of the Phase Matching GUI app. It allows users run the
%  automatic version of the code when the dataset is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-07-24
%  Updated: 2023-07-24

close all; clear; clc;


%% USERS INPUTS

FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\PhaseMatching\data\CardiacCycle\';
FilenameCh1 = '0-499-Nuc.tif';
FilenameCh2 = '0-499-Ca.tif';   % optional
FilenameCh3 = '';               % optional

MainCh = 1; % channel to be used for reference
Phase = 1;  % frame to be used for reference

NumScales = 5;
MinPeakHeight = 0;
MinPeakProminence = 0.05;

ROI = [236, 183, 338, 337];
Padding = 3;
CheckNeighbours = 2;

OutputName = 'PhaseMatchingOutput';
Output = '111';


%% Initiation
pathnames = {
    strcat(FolderPath, FilenameCh1), ...
    strcat(FolderPath, FilenameCh2), ...
    strcat(FolderPath, FilenameCh3)
    };
N_channels = sum([ ...
                ~isempty(FilenameCh1), ...
                ~isempty(FilenameCh2), ...
                ~isempty(FilenameCh3) ...
                ]);
pathnameChMain = pathnames{MainCh};
tifInfo = imfinfo(pathnameChMain);
img_ref = imread(pathnameChMain, Phase);
% figure(1);
% imshow(img_ref);
% title('This is our reference image for phase matching')


%% Preliminary Phase Matching
N = length(tifInfo);
ssim_score_lst = zeros(N,1);

for i_Frame = 1:N
    img_sug = imread(pathnameChMain, i_Frame);
    ssim_score = multissim3(img_sug, img_ref, NumScales = NumScales);
    ssim_score_lst(i_Frame) = ssim_score;
end

figure(2);
plot(1:N, ssim_score_lst);
hold on;
title('ssim scores');

[pks, pk_locs] = findpeaks(ssim_score_lst, ...
    MinPeakHeight = MinPeakHeight, ...
    MinPeakProminence = MinPeakProminence);
N_pks = length(pk_locs);

if Phase == 1
    pk_locs = [1; pk_locs];
    pks = [ssim_score_lst(1); pks];
end

figure(2);
plot(pk_locs, pks, "*")


%% ROI Based Phase Matching
distance_btwn_peaks = diff(pk_locs);
meanDist = mean(distance_btwn_peaks); %Average number of frames between peaks
numExtraImages = Padding;
cutLength = round(meanDist/2 + numExtraImages);
ImagesToSave = cell(N_channels, N_pks,2*cutLength+1);

xbounds = ceil(ROI(1)):floor(ROI(1)+ROI(3));
ybounds = ceil(ROI(2)):floor(ROI(2)+ROI(4));
n_neighbours = CheckNeighbours;

offset = 0;
for i = 1:N_pks-1
    if i~= 1
        ssim_vals = auto_correct(pathnameChMain, xbounds, ybounds, Phase, pk_locs(i), n_neighbours);
        [M_1, I_1] = max(ssim_vals);
        offset = I_1-n_neighbours-1;
    end
    k = 0;
    for j = -cutLength: 1: cutLength
        k = k + 1;
        frame_idx = pk_locs(i)+j+offset;
        for ch = 1:N_channels
            if frame_idx >= 1 && frame_idx <= length(tifInfo)
                ImagesToSave{ch, i, k} = imread(pathnames{ch}, frame_idx);
            else
                ImagesToSave{ch, i, k} = zeros(tifInfo(1).Height, tifInfo(1).Width);
            end
        end
    end
end


%% Output
outputFolder = OutputName;
outputFileName = OutputName;
folder_w = [FolderPath, outputFolder];
mkdir(folder_w);

javaaddpath('loci_tools.jar')
im=zeros(tifInfo(1).Height,tifInfo(1).Width, ...
    N_pks,N_channels,2*cutLength+1,'uint8'); %change to uint16 if using 16 bit images   
for k2 = 1:N_pks-1
    for k3 = 1:2*cutLength+1
        for ch = 1:N_channels
            im(:,:,k2,ch,k3) = ImagesToSave{ch,k2,k3};
        end
    end
end
    ImageFile = [outputFileName '_singleFile.ome'];
    bfsave(im, [folder_w, filesep, ImageFile])
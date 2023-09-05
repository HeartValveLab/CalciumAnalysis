%% Signal Analysis
%  A condensed script version of the Signal Analysis GUI app.
%  It allows users run the utomatic version of the code when the dataset 
%  is large on a HPC.
%
%  Author: Raymond Zhang
%  Created: 2023-08-07
%  Updated: 2023-09-05

close all; clc; clear;
addpath(genpath('utility'))


%% USERS INPUTS
disp('Reading user inputs');
FolderPath = 'C:\Users\rzha0171\Documents\GitHub\UROP\SampleData\CardiacCycle\';
FileNameNucCh = 'z005-Nuc.tif';
FileNameCaCh = 'z005-Ca.tif';
StartFrame = 1;
EndFrame = 0;
OutputFolder = 'CaSignalVsTime';
ExposureTime = 25;              % exposure time in milliseconds
MeanDist = 13.1351;             % frames per cycle
Visibility = 'off';             % display figures or not
load("SignalAnalysis\ROI_boundary.mat");       % load ROI_boundary


%% RUN CODE
run_signal_analysis(FolderPath, FileNameNucCh, FileNameCaCh, ...
    StartFrame, EndFrame, OutputFolder, ExposureTime, MeanDist, ...
    Visibility, ROI_boundary)

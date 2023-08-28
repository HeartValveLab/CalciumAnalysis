function [FilePaths, OutputPath, TifInfo, N_frames, N_channels, EndFrame] = initialise(FolderPath, FilenameNucCh, FilenameCaCh, StartFrame, EndFrame, OutputFolder);
    FilePaths = {
                strcat(FolderPath, FilenameNucCh), ...
                strcat(FolderPath, FilenameCaCh), ...
                };
    OutputPath = [FolderPath, OutputFolder];
    mkdir(OutputPath);
    TifInfo = imfinfo(FilePaths{1});
    if EndFrame == 0
        EndFrame = length(TifInfo);
    end
    N_frames = EndFrame - StartFrame - 1;
    N_channels = 2;
end
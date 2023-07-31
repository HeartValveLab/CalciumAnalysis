SET MATLABROOT="C:\Program Files\MATLAB\R2022b"
SET PATH=%MATLABROOT%;%PATH%
START matlab.exe -batch %1 -logfile c:\temp\logfile
PAUSE
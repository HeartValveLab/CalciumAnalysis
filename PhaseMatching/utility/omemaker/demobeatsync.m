% demobeatsync
% A file that demonstrates usage of beatsync. Copy and rename this file, then change parameters to fit your experiment.
% 
% beatsync implements the algorithms described in the following papers:
%
% [1] N. Chacko, K. Chan, M. Liebling, Paper in preparation.
% [2] J. Ohn, J. Yang, S.E.Fraser, R. Lansford,
%     and M. Liebling, "High-speed multicolor microscopy
%     of repeating dynamic processes," Genesis, vol. 49,
%     no. 7, pp. 514???521, 2011.
% [3] J. Ohn, H.-J. Tsai, M. Liebling, "Joint Dynamic Imaging of Morphogenesis and Function in the Developing Heart," Organogenesis, vol. 5, iss. 4, Oct./Nov./Dec. 2009.
% [4] M. Liebling, A.S. Forouhar, R. Wolleschensky, B. Zimmermann, R. Ankerhold, S.E. Fraser, M. Gharib, M.E. Dickinson, "Rapid Three-Dimensional Imaging and Analysis of the Beating Embryonic Heart Reveals Functional Changes During Development," Developmental Dynamics, vol. 235, iss. 11, pp. 2940-2948, November 2006.
% [5] M. Liebling, J. Vermot, A.S. Forouhar, M. Gharib, M.E. Dickinson, S.E. Fraser, "Nonuniform temporal alignment of slice sequences for four-dimensional imaging of cyclically deforming embryonic structures," Proceedings of the 3rd IEEE International Symposium on Biomedical Imaging: Macro to Nano (ISBI'06), Arlington, VA, USA, April 6-9, 2006, pp. 1156-1159.
% [6] M. Liebling, A. S. Forouhar, M. Gharib, S. E. Fraser, M. E. Dickinson, "Four-Dimensional Cardiac Imaging in Living Embryos via Postacquisition Synchronization of Nongated Slice Sequences," Journal of Biomedical Optics, vol. 10, no. 5, eid 054001, 10 pages, 2005.
%
% $LastChangedRevision: 6686 $
% $LastChangedBy: nchacko $
% $LastChangedDate: 2015-01-12 23:24:05 -0800 (Mon, 12 Jan 2015) $
% 
% Nikhil Chacko, Michael Liebling
% nchacko, liebling@ece.ucsb.edu
% (c) University of California Santa Barbara, 2011

% Heartdevsync Registration: parameters

% >> Read input data.vz
% > Order of dimensions in input data
p.Zdim = 4;
p.Cdim = 3;
p.Tdim = 1;
p.Rdim = 6;

% > Location of input files
% p.inputMode: (whether input data is available in) localmemory, singleFile, multipleFiles
p.inputMode = 'singleFile';

% a. Local memory


% b. Single file selection
p.volf='/data7/boselli/beatsync2_0/data/Emilie/ome/9.ome'
% c. Multiple file selection
p.inputDir='/data7/boselli/beatsyn';

% keyword present in all input filenames where an asterisk (*) denotes the part that varies
p.keyword = '*.ome';

% Filenames are expected to be lexicographically ordered as either rz or zr.
% e.g., if the filenames are ordered as file_r1_z1.ome, file_r1_z2.ome,
% file_r2_z1.ome, file_r2_z2.ome (i.e. if zs are grouped first) choose zr.
% Else, if the filenames are ordered as file_z1_r1.ome, file_z1_r2.ome,
% file_z2_r1.ome, file_z2_r2.ome (i.e. if repeats are grouped first) choose rz.
p.filenameOrder = 'zr';

% if experiments are repeated at multiple development times, specify the number
p.Nr = 1;


% >> Choose reference, ROI parameters
% > Choose a reference z-slice, channel and repeat. Assign it as -1 (default) to automatically select the middle z-slice, channel or repeat.
p.z0 = 0;
p.c0 = 1;
p.r0 = -1;

% > Choose a region of interest to improve synchronization performance (accuracy, speed, memory). Assign max. limit as Inf (default) to mean the highest possible value.
p.xmin = 1;
p.xmax = Inf;
p.ymin = 1;
p.ymax = Inf;

% > First reference time-frame
p.tmin = 16;

% > Last reference time-frame
p.tmax = 70;


% >> Synchronization mode
% > Should channels be locked (not mutually synchronized)?
p.lockdimC = 1;

% > It should be set to one of the following when lockdimC = 0.
%  'CRZNONE'- All slices are aligned to c0,z0,r0, non-recursively.
%  'CONLY'  - Slices are aligned recursively along C but non-recursively along R and Z.
%  'RONLY'  - Slices are aligned recursively along R but non-recursively along C and Z.
%  'ZONLY'  - Slices are aligned recursively along Z but non-recursively along C and R.
%  'CRONLY' - Slices are aligned recursively along C and R but non-recursively along Z.
%  'RZONLY' - Slices are aligned recursively along R and Z but non-recursively along C [DEFAULT].
%  'CZONLY' - Slices are aligned recursively along C and Z but non-recursively along R.
%  'CRZONLY'- Slices are aligned recursively along both C, Z and R, starting from slice (c0,z0,r0)
% It should be set to one of the following when lockdimC = 1
%  'RZNONE' - All slices are aligned to z0,r0, non-recursively.
%  'RONLY'  - Slices are aligned recursively along R but non-recursively along Z.
%  'ZONLY'  - Slices are aligned recursively along Z but non-recursively along R.
%  'RZONLY' - Slices are aligned recursively along R and Z [DEFAULT]
p.recursive = 'RZONLY';


% >> Write output data.
p.outputDir='/data7/boselli/beatsync2_0/data/Emilie/'
p.outputFilename='/data7/boselli/beatsync2_0/data/Emilie/ome/9.ome'
% > Save each synchornized z-slice separately?
p.saveZSeparately = 0;

p.saveAsMAT = 0;
p.saveAsOME = 0;
p.saveAsOMETiIFF = 1;

p.saveParams = 1;

% > Save time lapse for each time-point in cardiac cycle?
p.saveXYZCR = 0;

% >> Run synchronization algorithm
p_out = beatsync(p);

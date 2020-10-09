% Example of import meta-analysis fMRI result synthesized by Neurosynth
%
% K. Suzuki 2020-10-09
%
% Copyright (C) 2011, ATR All Rights Reserved.
% License : New BSD License(see VBMEG_LICENSE.txt)

% Brain files
fmri_parm.brain_file  = PATH_OF_BRAINFILE; % brain.mat
fmri_parm.act_file    = PATH_OF_ACTFILE; % act.mat
fmri_parm.area_file   = PATH_OF_AREAFILE; % area.mat
fmri_parm.spm_normalization_file = PATH_OF_NORMALIZATIONFILE; %_sef_sn.mat

% Neurosynth path
dir_neurosynth  = DIR_NEUROSYNTH; % directory of neurosynth results
term = 'visual'; % selected meta-analysis data as prior (e.g. visual)
file_nii = 'association-test_z_FDR_0.01.nii'; % name of nifti file to be imported

% Init fmri_parm
fmri_parm = [];
fmri_parm.SPMmapmode    = 'mni2subj'; % must be mni2subj if imgfile is from SPM
fmri_parm.Tthres = 0; % no threshold
fmri_parm.Rthres = 3;

% Import meta-analysis prior to actfile
dir_meta = fullfile(dir_neurosynth, term);
if ~exist(fullfile(dir_meta,file_nii),'file')
    gunzip([fullfile(dir_meta,file_nii) '.gz']);
end
fmri_parm.SPMimginfo(1) = struct('dirname', [dir_meta filesep],...
    'imgfilename', file_nii, 'imglabel', term, ...
    'spm_ver', 'SPM8');

vb_job_fmri_meta(fmri_parm); % write prior data to act and area file
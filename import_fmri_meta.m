function import_fmri_meta(p)
% Import meta-analysis fMRI result synthesized by Neurosynth
%
% K. Suzuki 2020-10-09
% Y. Takeda 2019-01-05
%
% Copyright (C) 2011, ATR All Rights Reserved.
% License : New BSD License(see VBMEG_LICENSE.txt)

disp(mfilename);

% Not to confirm the permission to overwrite .act.mat file
global vbmeg_inst
vbmeg_inst.verbose_level=2;

% Neurosynth path
dir_neurosynth  = '/home/cbi-data33/k_suzuki/Data/meta-analysis/neurosynth/v07/fMRI'; % directory of neurosynth results
term = 'visual'; % selected meta-analysis data as prior
file_nii = 'association-test_z_FDR_0.01.nii'; % name of nifti file to be imported

% Init fmri_parm
fmri_parm = [];
fmri_parm.SPMmapmode    = 'mni2subj'; % must be mni2subj if imgfile is from SPM
fmri_parm.Tthres = 0; % no threshold
fmri_parm.Rthres = 3;

% Brain file (relative path from proj_root)
fmri_parm.brain_file  = fullfile(p.proj_root, p.brain_dirname, [p.struct_name, '.brain.mat']);
fmri_parm.act_file    = fullfile(p.proj_root, p.brain_dirname, [p.struct_name, '.act.mat']);
fmri_parm.area_file   = fullfile(p.proj_root, p.brain_dirname, [p.struct_name, '.area.mat']);
fmri_parm.spm_normalization_file = fullfile(p.proj_root, p.t1_dirname, ['m' p.struct_name '_seg_sn.mat']);

% Import meta-analysis prior
dir_meta = fullfile(dir_neurosynth, term);
if ~exist(fullfile(dir_meta,file_nii),'file')
    gunzip([fullfile(dir_meta,file_nii) '.gz']);
end
fmri_parm.SPMimginfo(1) = struct('dirname', [dir_meta filesep],...
    'imgfilename', file_nii, 'imglabel', term, ...
    'spm_ver', 'SPM8');

vb_job_fmri_meta(fmri_parm); % write prior data to act and area file

vbmeg_inst.verbose_level=3;
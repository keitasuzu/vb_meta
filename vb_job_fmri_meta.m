function vb_job_fmri_meta(varargin)
% IMPORT FMRI RESULTS TO VBMEG ACT AND AREA FILES
% Support SPM earlier than spm8, tested with spm8  
%
% [Syntax]
%    vb_job_fmri(proj_root, fmri_parm);
%    vb_job_frmi(fmri_parm);
%
% [Input]
%    proj_root : <<string>> VBMEG project root directory.
%    fmri_parm : Import parameters for fmri.
%
% [Output]
%    none
%
% [History]
%   2020/10/09 k_suzuki
%     [Change] modification for meta-analysis fMRI data
%   2016/11/21 rhayashi
%     [Change] spec of SPMmapmode changed more clearly e.g. 'mni' -> 'mni2subj'
%   2016/07/26 O.Yamahista
%     [Change] spm_ver is obtained from SPM.mat 
%   2016/07/12 O.Yamahista
%     [Fix] bug fix when importing SPM maps on MNI brain to the MNI brain model 
%   2016/07/05 O.Yamashita
%     [Add] process to project normalized SPM maps on the MNI brain model
%   2016/07/03 O.Yamashita
%     initial version
%
% [Note]
%   @see vb_set_fmri_parm.m
%
% Copyright (C) 2011, ATR All Rights Reserved.
% License : New BSD License(see VBMEG_LICENSE.txt)

%
% --- Previous check
%
spm_func = which('spm_vol');
if isempty(spm_func)
    error('Please add SPM8 path to your MATLAB.');
end
if nargin == 1
    proj_root = '';
    parm = varargin{1};
elseif nargin == 2
    proj_root = varargin{1};
    parm      = varargin{2};
else
    error('Invalid usage of vb_job_fmri.');
end

proj_root = vb_rm_trailing_slash(proj_root);

%
% --- Main Procedure
%

% PARAMETERS
% SPM results
% SPMmat_file = parm.SPMmat_file;
brain_file  = fullfile(proj_root, parm.brain_file);

% Resutls output 
act_file    = fullfile(proj_root, parm.act_file);
area_file   = fullfile(proj_root, parm.area_file);
% keys_postfix = parm.keys_postfix; 

% function mode
Tthres  = parm.Tthres;      % important parameters
Rthres  = parm.Rthres;      % unit:mm
% PSthres = parm.PSthres;     % unit:%
SPMmapmode = parm.SPMmapmode;
SPMimginfo = parm.SPMimginfo;


switch lower(SPMmapmode)
    case {'subj2subj'}
        error('SPMmapmode must be ''mni2subj'' !');

    case {'mni2subj'}
        % SPM results on MNI brain --> Subject brain
        %  need input parameter check
        sn_file     = parm.spm_normalization_file;
        vb_fmri_unsn_project_Tmap_cortex(brain_file,act_file,area_file,sn_file,Tthres,Rthres,SPMimginfo);

    case {'mni2mni'}
        error('SPMmapmode must be ''mni2subj'' !');
                
    otherwise
        error('SPMmapmode must be ''mni2subj'' !');
end

%--------------------------
% Save project file
%--------------------------
% proj_file = get_project_filename;
% if ~isempty(proj_file)
%     project_file_mgr('load', proj_file);
%     project_file_mgr('add', 'fmri_parm', parm);
% end

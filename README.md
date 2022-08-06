# vb_meta

Import fuction of meta-analysis fMRI data to VBMEG's actfile.  
"vb_job_fmri_meta.m" function is compatible with "vb_job_fmri.m" of VBMEG.  
When you import meta-analysis fMRI data, use this function instead of "vb_job_fmri.m".  
If you are familier with VBMEG, read "example_vb_job_fmri_meta.m" for usage.  

We also have [VBMEG tutorial](https://vbmeg.atr.jp/docs/v2/static/vbmeg2_tutorial_neuromag.html).  
This tutorial reproduces the results of group analysis in [Suzuki2020](https://www.sciencedirect.com/science/article/pii/S1053811921003116?via%3Dihub).  
"vb_job_fmri_meta.m" will be called in [4.1. Importing fMRI activity] of the tutorial.  
We also opened the function "import_fmri_meta.m" that compatible with "import_fmri.m" in the tutorial.  

When you try to conduct above, please prepare your own meta-analysis data derived from [Neurosynth](https://neurosynth.org) or other meta-analysis tools.

For the general issue about VBMEG, please go to [VBMEG official](https://vbmeg.atr.jp).  

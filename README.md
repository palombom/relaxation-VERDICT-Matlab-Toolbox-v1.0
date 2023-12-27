# rVERDICT

This repository contains the latest release of the rVERDICT Toolbox.

The "***rVERDICT (relaxation-VERDICT) Toolbox***" enables model-based joint estimation of relaxation and diffusion tissue parameters for prostate cancer using Machine Learning (see the original rVERDICT paper for model assumptions and acquisition requirements DOI: [https://doi.org/10.1016/j.neuroimage.2020.116835](https://doi.org/10.1038/s41598-023-30182-1)).

For queries about the toolbox or suggestions on how to improve it, please email: palombom@cardiff.ac.uk

## Dependencies
To use the current implementation of rVERDICT Toolbox you will need a MATLAB distribution with the Parallel Computing Toolbox, the Statistics and Machine Learning Toolbox and the Optimization Toolbox. Additionally, you will also need Python with:
- scipy
- numpy
- sklearn
- pickle

and the external matlab repository: [Tools for NIfTI and ANALYZE image] Jimmy Shen (2022). Tools for NIfTI and ANALYZE image (https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image), MATLAB Central File Exchange. Retrieved April 16, 2022.

## Download 
To get the rVERDICT Toolbox clone this repository.

If you use Linux or MacOS:

1. Open a terminal;
2. Navigate to your destination folder;
3. Clone rVERDICT Toolbox:
```
$ git clone https://github.com/palombom/rVERDICT.git 
```
The main function is called "**main_rVERDICT_analysis**" and it analyses one dataset with the rVERDICT model. 

## Usage
The function "main_rVERDICT_analysis" represents the core of the toolbox. It performs the rVERDICT analysis on one dataset. It assumes that data are organized as following:

- DataFolder
  - data.nii.gz
  - data_mask.nii.gz
  - data.bval
  - data.delta
  - data.smalldel
  - data.te
  - data.tr

**INPUT** to the "main_rVERDICT_analysis" are: the 'DataFolder', which is the folder where the data are stored, and the 'pythonpath' which is the full path to the python binary file. Inside 'DataFolder', the data (in nifti GZ compressed format) is expected to be called 'data.nii.gz', alongside the mask called 'data_mask.nii.gz'; bval file 'data.bval' in FSL format (in s/mm^2); the diffusion gradient pulse separation (delta) and duration (smalldel) in the files 'data.delta' and 'data.smalldel', respectively; the echo time TE in the file 'data.te' and the repetition time TR in the file 'data.tr', all in seconds. These files for the VERDICT acquisition in the original rVERDICT paper are included as reference in the folder 'EXAMPLES_bval_delta_smalldel_te_tr'.  

**OUTPUT** of the analysis will be stored in a new folder 'DataFolder -> rVERDICT_output' where the rVERDICT maps: 'f_ic', 'f_ees', 'f_vasc' (=1 - f_ic - f_ees), 'R', 'D_ees', 'T2_ic', 'T2_vasc_ees' , 'T1' and 'S0' are saved.

## Citation
If you use this rVERDICT Toolbox, please remember to cite our main rVERDICT work:

Palombo, M., Valindria, V., Singh, S., Chiou, E., Giganti, F., Pye, H., ... & Panagiotaki, E. Joint estimation of relaxation and diffusion tissue parameters for prostate cancer with relaxation-VERDICT MRI. Scientific Reports 2023: 13(1), 2999. https://doi.org/10.1038/s41598-023-30182-1


## License
rVERDICT Toolbox is distributed under the BSD 2-Clause License (https://github.com/palombom/rVERDICT/blob/main/LICENSE), Copyright (c) 2022 Cardiff University and University College London. All rights reserved.

**The use of rVERDICT Toolbox MUST also comply with the individual licenses of all of its dependencies.**

## Acknowledgements
The development of rVERDICT was supported by the UKRI Future Leaders Fellowship MR/T020296/2 and EPSRC Grants EP/N021967/1 and EP/R006032/1 and by Prostate Cancer UK: Targeted Call 2014: Translational Research St.2, project reference PG14-018-TR2.


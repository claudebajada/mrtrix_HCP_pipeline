#! /bin/bash
#
# dwi_pipeline.sh
# Copyright (C) 2019 Claude Bajada <claude.bajada@um.edu.mt>
#
# Distributed under terms of the MIT license.
#

Subject=$1

mkdir ${Subject}/MRtrix3

export ANTSPATH=${HOME}/bin/ants/bin/
export PATH=${ANTSPATH}:$PATH

5ttgen fsl ${Subject}/T1w/T1w_acpc_dc_restore_brain.nii.gz ${Subject}/MRtrix3/5TT.mif -premasked

mrconvert ${Subject}/T1w/Diffusion/data.nii.gz ${Subject}/MRtrix3/DWI.mif \
   -fslgrad bvecs bvals -datatype float32 -strides 0,0,0,1

dwibiascorrect -ants ${Subject}/MRtrix3/DWI.mif ${Subject}/MRtrix3/DWI_bias_corr.mif

dwi2mask ${Subject}/MRtrix3/DWI_bias_corr.mif ${Subject}/MRtrix3/mask.mif

dwiextract ${Subject}/MRtrix3/DWI_bias_corr.mif - -bzero | mrmath - mean ${Subject}/MRtrix3/meanb0.mif -axis 3

dwi2response dhollander \
   ${Subject}/MRtrix3/DWI_bias_corr.mif \
   ${Subject}/MRtrix3/RF_WM.txt \
   ${Subject}/MRtrix3/RF_GM.txt \
   ${Subject}/MRtrix3/RF_CSF.txt \
  -voxels ${Subject}/MRtrix3/RF_voxels.mif



#! /bin/bash
#
# dwi_pipeline.sh
# Copyright (C) 2019 Claude Bajada <claude.bajada@um.edu.mt>
#
# Distributed under terms of the MIT license.
#

Subject=$1

dwi2fod msmt_csd \
  DWI_bias_corr.mif \
  ./GroupMRtrix3/group_average_response_wm.txt ${Subject}/MRtrix3/WM_FODs.mif \
  ./GroupMRtrix3/group_average_response_gm.txt ${Subject}/MRtrix3/GM.mif \
  ./GroupMRtrix3/group_average_response_csf.txt ${Subject}/MRtrix3/CSF.mif \
  -mask ${Subject}/MRtrix3/mask.mif

mtnormalise \
  ${Subject}/MRtrix3/WM_FODs.mif ${Subject}/MRtrix3/WM_FODs_norm.mif \
  ${Subject}/MRtrix3/GM.mif ${Subject}/MRtrix3/GM_norm.mif \
  ${Subject}/MRtrix3/CSF.mif ${Subject}/MRtrix3/CSF_norm.mif \
  -mask ${Subject}/MRtrix3/mask.mif

tckgen ${Subject}/MRtrix3/WM_FODs_norm.mif ${Subject}/MRtrix3/10M_prob.tck \
  -algorithm iFOD2 \
  -seed_dynamic ${Subject}/MRtrix3/WM_FODs_norm.mif \
  -maxlength 250 \
  -select 10M \
  -cutoff 0.06

tcksift2 -act ${Subject}/MRtrix3/ ${Subject}/MRtrix3/5TT.mif \
  ${Subject}/MRtrix3/10M_prob.tck \
  ${Subject}/MRtrix3/10M_prob.sift




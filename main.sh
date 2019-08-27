#! /bin/bash
#
# dwi_pipeline.sh
# Copyright (C) 2019 Claude Bajada <claude.bajada@um.edu.mt>
#
# Distributed under terms of the MIT license.
#

# we assume that the folder structure is the HCP one

root_folder=$1

cd ${root_folder} # input the root so that all it contains is the subject folders of interest.
foreach * : bash ./step_1 IN
bash ./step_2
foreach * : bash ./step_3 IN

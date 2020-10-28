#!/bin/bash
#
# Author: Caroline Nettekoven
# FMRIB, Oxford University
# 02.09.2020
#
# ------------------------------------------------------------------------------
# Set paths
BIDSraw=/vols/Data/devcog/projects/BOLD
py_dir=/home/fs0/cnette/.local/bin/
dir_local=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/face_removal/inspect_defacing
# ------------------------ Generate input lists ------------------------
problem_subjects=" \
636BH \
638BL \
640BT \
648BT \
657BH \
660BH \
666BT \
670BT \
"
# ------------------------------------------------------------------------------
# ------------------------ Inspect problem subjects ------------------------
cd ${BIDSraw}
for subject in ${problem_subjects}; do
    # raw_image=${BIDSraw}/sub-${subject}/anat/sub-${subject}_T1w_raw_orig.nii.gz
    all_func_images=`ls sub-${subject}/anat/sub-${subject}_T1w_*.nii.gz`
    fsleyes ${all_func_images}
done

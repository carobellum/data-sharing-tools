#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  deface_test.sh
#
# Description:  Test defacing on example subject
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
source $FREESURFER_HOME/SetUpFreeSurfer.sh
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
input_dir=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/sub-650BT/
work_dir=${input_dir}/defaced/dicom
tool_dir=/Users/CN/Documents/Projects/BOLD_study_local/bin/
py_dir=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env/bin
# ------------------------------------------------------------------------------
dicom_folders_to_deface="W3T_2018_101_150/BOLD_2p4_MB6_P1_TE30_TR800_AP_2_1"
# ------------------------------------------------------------------------------

for folder in ${dicom_folders_to_deface}; do
    echo "Defacing ${folder}..."
    
    for image in ${input_dir}/${folder}/MR.*; do
        echo $image
        
        img_stem=${image#*MR.}
        
        ${tool_dir}/mri_deface \
        ${image} \
        ${tool_dir}/talairach_mixed_with_skull.gca \
        ${tool_dir}/face.gca \
        ${work_dir}/MR.${img_stem}_freesurfer.dcm
    done
done

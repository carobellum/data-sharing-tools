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
input_dir=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/sub-650BT/
work_dir=${input_dir}/defaced
tool_dir=/Users/CN/Documents/Projects/BOLD_study_local/bin/
py_dir=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env/bin
# ------------------------------------------------------------------------------
images_to_deface="\
anat/sub-650BT_T1w_nrm.nii.gz \
anat/sub-650BT_T1w_raw.nii.gz \
dwi/sub-650BT_acq-AP_dwi.nii.gz \
dwi/sub-650BT_acq-AP_sbref.nii.gz \
dwi/sub-650BT_acq-PA_dwi.nii.gz \
dwi/sub-650BT_acq-PA_sbref.nii.gz \
fmap/sub-650BT_magnitude1.nii.gz \
fmap/sub-650BT_magnitude2.nii.gz \
fmap/sub-650BT_phase.nii.gz \
func/sub-650BT_task-nwr_bold.nii.gz \
func/sub-650BT_task-nwr_sbref.nii.gz \
func/sub-650BT_task-rest_bold.nii.gz \
func/sub-650BT_task-rest_sbref.nii.gz \
func/sub-650BT_task-verbgen_bold.nii.gz \
func/sub-650BT_task-verbgen_sbref.nii.gz \
"
# ------------------------------------------------------------------------------

for image in ${images_to_deface}; do
    echo "Defacing ${image}..."

    img=${input_dir}/${image}
    img_stem=${image#*BT_}
    img_stem=${img_stem%.nii*}

    if [ ! -f ${work_dir}/${img_stem}_pydeface.nii.gz ]; then
    ${py_dir}/pydeface --outfile \
    ${work_dir}/${img_stem}_pydeface \
    ${img}
    fi

    if [ ! -f ${work_dir}/${img_stem}_fsl.nii.gz ]; then
    fsl_deface \
    ${img} \
    ${work_dir}/${img_stem}_fsl
    fi

    if [ ! -f ${work_dir}/${img_stem}_freesurfer.nii.gz ]; then
    ${tool_dir}/mri_deface \
    ${img} \
    ${tool_dir}/talairach_mixed_with_skull.gca \
    ${tool_dir}/face.gca \
    ${work_dir}/${img_stem}_freesurfer.nii.gz
    fi

done
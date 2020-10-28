#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  deface_test.sh
#
# Description:  Check defacing on example subject for all available modalities
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Set free parameters (Loop through these for several subjects)
input_dir=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/sub-650BT/
output_dir=${input_dir}/defaced
# ------------------------------------------------------------------------------
# Set paths for defacing tools
tool_dir=/Users/CN/Documents/Projects/BOLD_study_local/bin/
py_dir=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env/bin
# ------------------------------------------------------------------------------
images_to_deface=" \
anat/sub-650BT_T1w_nrm.nii.gz \
anat/sub-650BT_T1w_raw.nii.gz \
dwi/sub-650BT_acq-AP_dwi.nii.gz \
dwi/sub-650BT_acq-AP_sbref.nii.gz \
dwi/sub-650BT_acq-PA_dwi.nii.gz \
dwi/sub-650BT_acq-PA_sbref.nii.gz \
func/sub-650BT_task-nwr_bold.nii.gz \
func/sub-650BT_task-nwr_sbref.nii.gz \
func/sub-650BT_task-rest_bold.nii.gz \
func/sub-650BT_task-rest_sbref.nii.gz \
func/sub-650BT_task-verbgen_bold.nii.gz \
func/sub-650BT_task-verbgen_sbref.nii.gz \
"
# ------------------------------------------------------------------------------

for image in ${images_to_deface}; do
    # Set face constructing threshold dependent on modality (thresholds are chosen so that facial features are best visible)
    if [[ ${image:0:3} == "ana" ]] ; then
        thr=30
    elif [[ ${image:0:3} == "fun" ]]; then
        thr=50
    elif [[ ${image:0:3} == "dwi" ]]; then
        thr=45
    fi
    # echo ${image:0:3} ${image_name: -2} "       " ${thr}

    # ---------- Copy and face reconstruct original image: ----------
    img_stem=${image#*/}
    img_stem=${img_stem%.nii*}

    # extract example slice from original image
    dim=$(( `fslval ${input_dir}/${image} dim4` -1 ))
    if (( `fslval ${input_dir}/${image} dim4` > 0)); then
        dim=`echo " \`fslval ${input_dir}/${image} dim4\` /2 " | bc ` ;
    fi
    fslroi \
    ${input_dir}/${image} \
    ${output_dir}/${img_stem}_orig \
    0 -1 0 -1 0 -1 ${dim} 1

    # Reconstruct face based on the original image:
    if [[ ! -f ${output_dir}/${img_stem}_orig.png ]]; then
        sh ${tool_dir}/fsl_gen_3D_crn_thr \
            ${output_dir}/${img_stem}_orig.nii.gz \
            ${output_dir}/${img_stem}_orig \
            ${thr}
    fi

    # ---------- Copy and face reconstruct defaced image: ----------
    # Reconstruct face based on the defaced images
    for img_defaced in ${output_dir}/${img_stem:10}_*.nii.gz; do
            sh ${tool_dir}/fsl_gen_3D_crn_thr \
                ${img_defaced} \
                ${img_defaced%.nii*} \
                ${thr}
    done
done


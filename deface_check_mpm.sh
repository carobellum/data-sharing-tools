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
# Set free parameters (Loop through these for several subjects)
input_dir=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/sub-650BT/
output_dir=${input_dir}/defaced
# ------------------------------------------------------------------------------
# Set paths for defacing tools
tool_dir=/Users/CN/Documents/Projects/BOLD_study_local/bin/
py_dir=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env/bin
# ------------------------------------------------------------------------------
images_to_deface=" anat/sub-650BT_T1w_nrm.nii.gz \
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
mpm/hMRI_NIFTI/mfc_3dflash_T1w_GRAPPA4_0023/s2019-05-18_12-03-130720-00001-01056-6.nii \
mpm/hMRI_NIFTI/mfc_seste_b1map_0018/s2019-05-18_12-03-125817-00006-00481-1.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_A.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_MT.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_R1.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_R2s_OLS.nii "
# ------------------------------------------------------------------------------

for image in ${images_to_deface}; do
    # Set face constructing threshold dependent on modality (thresholds are chosen so that facial features are best visible)
    image_name=""
    if [[ ${image:0:3} == "mpm" ]]; then
        image_name=${image%*.nii}
        if [[ ${image_name: -2} == "MT" ]] || [[ ${image_name: -2} == "R1" ]] || [[ ${image_name: -2} == "LS" ]]; then
            thr=80
        elif [[ ${image_name: -1} == "6" ]]; then
            thr=65
        elif [[ ${image_name: -1} == "1" ]]; then
            thr=40
        elif [[ ${image_name: -1} == "A" ]]; then
            thr=30
        fi
    fi
    # echo ${image:0:3} ${image_name: -2} "       " ${thr}

    # ---------- Copy and face reconstruct original image: ----------
    img=${input_dir}/${image}
    img_stem=${image#*sub-???B?}
    img_stem=${img_stem%.nii*}

    # extract example slice from original image
    ${FSLDIR}/bin/fslroi ${img} ${output_dir}/${img_stem}_orig 0 -1 0 -1 ${dim} 1;

    # Reconstruct face based on the original image:
    orig=${output_dir}/${img_stem}_orig
    if [[ ! -f ${orig}.png ]]; then
        sh ${tool_dir}/fsl_gen_3D_crn_thr \
            ${img} \
            ${orig} \
            ${thr}
    fi

    # ---------- Copy and face reconstruct defaced image: ----------
    # Reconstruct face based on the defaced images
    for img_defaced in ${output_dir}/*.nii.gz; do

        if [[ ! -f ${img_defaced%.nii*}_2.png ]]; then
            sh ${tool_dir}/fsl_gen_3D_crn_thr \
                ${img_defaced} \
                ${img_defaced%.nii*} \
                ${thr}
        fi
    done
done


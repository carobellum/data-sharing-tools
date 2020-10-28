#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  deface_test_nifti_mpm.sh
#
# Description:  Test defacing on example subject for all mpm scans
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
input_dir=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/sub-600BL/
work_dir=${input_dir}/defaced
tool_dir=/Users/CN/Documents/Projects/BOLD_study_local/bin/
py_dir=/Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env/bin
# ------------------------------------------------------------------------------
images_to_deface=" \
mpm/hMRI_NIFTI/fieldmap_gre_2mm_iso_0019/s2019-05-18_12-03-125937-00001-00001-2.nii \
mpm/hMRI_NIFTI/mfc_3dflash_T1w_GRAPPA4_0023/s2019-05-18_12-03-130720-00001-01056-6.nii \
mpm/hMRI_NIFTI/mfc_seste_b1map_0018/s2019-05-18_12-03-125817-00006-00481-1.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_A.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_MT.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_R1.nii \
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_R2s_OLS.nii "
# ------------------------------------------------------------------------------

for image in ${images_to_deface}; do
    echo "Defacing ${image}..."

    img=${input_dir}/${image}
    img_stem=${image: -10}
    img_stem=${img_stem%.nii*}

    # ${py_dir}/pydeface \
    # --outfile ${work_dir}/${img_stem}_pydeface \
    # ${img}

    # fsl_deface \
    # ${img} \
    # ${work_dir}/${img_stem}_fsl

    # ${tool_dir}/mri_deface \
    # ${img} \
    # ${tool_dir}/talairach_mixed_with_skull.gca \
    # ${tool_dir}/face.gca \
    # ${work_dir}/${img_stem}_freesurfer.nii.gz




    # Find threshold
    # Copy and face reconstruct original image:
    dim=`echo "\`${FSLDIR}/bin/fslval ${img} dim3\` /2" |bc ` ;
    ${FSLDIR}/bin/fslroi ${img} ${output_dir}/${img_stem}_orig 0 -1 0 -1 ${dim} 1;

    for thr in 30 35 40 45 50 55 60 65 70 75 80; do
    sh ${tool_dir}/fsl_gen_3D_crn_thr \
                ${img} \
                ${output_dir}/thresholding/${img_stem}_orig_thr${thr} \
                ${thr}
    done
done


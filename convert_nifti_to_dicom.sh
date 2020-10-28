#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  convert_nifti_to_dicom.sh
#
# Description:  Script to convert niftis to dicom (needs fixing)
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
mpm/PSN_results/Results/s2019-05-18_12-03-130232-00001-00176-1_R2s_OLS.nii "
# ------------------------------------------------------------------------------



SCL=`dcmdump -s +P 2005,100e 02_MPRAGE.dcm | awk '{print $3}'`
export FSLOUTPUTTYPE=NIFTI_PAIR
# export FSLOUTPUTTYPE=NIFTI_GZ # Default setting


SCL=`dcmdump ${dicom_file} | grep "SpacingBetweenSlices" | awk '{print $3}' | sed 's/[][]//g'`
export FSLOUTPUTTYPE=NIFTI_PAIR
fslmaths ${nifti_file} -mul ${SCL} ${nifti_file} -odt short
fslswapdim ${nifti_file}.hdr x -y z ${nifti_file}_2
mv ${dicom_file} task-rest_sbref_fsl.dcm
dcmodify -mf 7fe0,0010=${nifti_file}_2.img ${nifti_file}.dcm
# rm 02_MPrage.nii 02_MPrage.json 02_MPrage_deface.* 02_MPrage_deface2.*

nifti_file=task-rest_sbref_fsl
dicom_file=MR.1.3.12.2.1107.5.2.43.66093.2019090715462780951420689

scp MR.1.3.12.2.1107.5.2.43.66093.2019090715462780951420689 ${nifti_file%.nii*}.dcm


fslmaths 02_MPrage_deface.nii -mul $SCL 02_MPrage_deface -odt short

fslswapdim 02_MPrage_deface.hdr x -y z 02_MPrage_deface2

dcmodify -mf 7fe0,0010=02_MPrage_deface2.img 02_MPrage_deface.dcm


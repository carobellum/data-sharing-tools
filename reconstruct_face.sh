#! /bin/sh
# ------------------------------------------------------------------------------
# Script name:  deface_test.sh
#
# Description:  Test defacing on example subject
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
prog=`basename $0`
usage="Usage $prog input_dir input_type "
# Set free parameters (Loop through these for several subjects)
input_dir=$1
input_type=$2
output_dir=${input_dir}/slicesdir
# ------------------------------------------------------------------------------
# Set paths for defacing tools
tool_dir=/vols/Data/devcog/projects/BOLD/bin
# ------------------------------------------------------------------------------
images_to_reconstruct=`ls ${input_dir}/*.nii*`
# ------------------------------------------------------------------------------
# Set face constructing threshold dependent on modality (thresholds are chosen so that facial features are best visible)
if [[ ${input_type:0:3} == "ana" ]] ; then
    thr=30
    elif [[ ${input_type:0:3} == "fun" ]]; then
    thr=50
    elif [[ ${input_type:0:3} == "dwi" ]]; then
    thr=45
fi

for image in ${images_to_reconstruct}; do
    
    
    img_stem=${image#*anat//*}
    img_stem=${img_stem%.nii*}
    
    # Extract example volume if image has several volumes
    dim=$(( `fslval ${image} dim4` -1 ))
    if (( `fslval ${image} dim4` > 1)); then
        echo "Image has more than one volume. Extracting example volume..."
        
        dim=`echo " \`fslval ${image} dim4\` /2 " | bc ` ;
        
        echo fslroi \
        ${image} \
        ${output_dir}/${img_stem}_example \
        0 -1 0 -1 0 -1 ${dim} 1
        
        reconstruct_this_img=${output_dir}/${img_stem}_example
    else
        reconstruct_this_img=${image}
    fi
    
    # Reconstruct face
    if [[ ! -f ${output_dir}/${img_stem}.png ]]; then
        sh ${tool_dir}/fsl_gen_3D_crn_thr \
        ${reconstruct_this_img} \
        ${output_dir}/${img_stem}_recon \
        ${thr}
        
        ls ${output_dir}/${img_stem}_recon*
    fi
    
done


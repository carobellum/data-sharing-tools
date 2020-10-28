#!/bin/bash
#
# Author: Caroline Nettekoven
# FMRIB, Oxford University
# 02.09.2020
#
# N.B. When using this script for a new dataset, you can get rid of most of the if conditions. Those are specific to the BOLD dataset, to account for failed defacing (due to broken pipe)
# ------------------------ Generate input lists ------------------------

ls /vols/Data/devcog/projects/BOLD/sub-*/anat/sub-*raw.nii.gz > /vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt
ls sub-*/func/sub-*.nii.gz > /vols/Data/devcog/projects/BOLD/bin/list_of_funcs.txt

for image in ; do
    img=${image%.nii*}
    
    # Make copy of original
    fsl_sub fslmaths ${img} ${img}_orig
    
    
    # Deface original
    # fsl_deface \
    # ${img} \
    # ${img}
done

# ------------------------ Make copy of original ------------------------
cd /vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats.txt"
while read image; do
    # echo "$image"
    img=${image%.nii*}
    
    owner=` ls -l ${image} | awk '{print $3}' `
    create_mon=` ls -l ${image} | awk '{print $6}' `
    create_day=` ls -l ${image} | awk '{print $7}' `
    
    # Make copy of original
    # if [ ! $owner == "cnette" ] && [ ! $create_mon == "Sep" ] && [ ! $create_day == "2" ] && [ ! -f ${img}_orig.nii.gz ]; then
    if [ ! -f ${img}_orig.nii.gz ]; then
        echo Copying $image...
        fslmaths ${img} ${img}_orig
    fi
    
done < "$input"

# ------------------------ Deface ------------------------
cd /vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats.txt"
while read image; do
    img=${image%.nii*}
    owner=` ls -l ${image} | awk '{print $3}' `
    change_year=` ls -l ${image} | awk '{print $8}' `
    change_mon=` ls -l ${image} | awk '{print $6}' `
    change_day=` ls -l ${image} | awk '{print $7}' `
    if [ -f ${img}_orig.nii.gz ] && [ ! ${change_mon} == "Sep" ] ; then
        if [ ! ${change_day} == "2" ] && [ ! ${change_day} == "7" ]; then
            echo "${image} defacing..."
            fsl_deface \
            ${img} \
            ${img}
            elif [ -f ${img}_orig.nii.gz ] && [ ${change_year} == "2018" ]; then
            echo "2018 ${image} defacing..."
            fsl_deface \
            ${img} \
            ${img}
            elif [ -f ${img}_orig.nii.gz ] && [ ${change_year} == "2019" ]; then
            echo "2019 ${image} defacing..."
            fsl_deface \
            ${img} \
            ${img}
        fi
    fi
done < "$input"
# ------------------------ Create defacing report ------------------------
BIDSraw=/vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt"
while read image; do
    cd ${BIDSraw}
    
    img=${image%.nii*}
    change_mon=` ls -l ${image} | awk '{print $6}' `
    change_day=` ls -l ${image} | awk '{print $7}' `
    
    change_mon_nrm=` ls -l ${img%_raw}_nrm.nii.gz | awk '{print $6}' `
    change_day_nrm=` ls -l ${img%_raw}_nrm.nii.gz | awk '{print $7}' `
    # if [ ${change_mon} == "Sep" ] && [ ${change_mon_nrm} == "Sep" ] ; then
    #     if [ ${change_day} == "2" ] || [ ${change_day} == "7" ] || [ ${change_day} == "8" ] ; then
    #         if [ ${change_day_nrm} == "2" ] || [ ${change_day_nrm} == "7" ] || [ ${change_day_nrm} == "8" ]; then
    if [ ! -d ${image%sub*}/slicesdir ]; then
        echo " "
        echo " --------------- "
        echo "Generating report for ${img%_raw} images..."
        
        cd ${image%sub*}
        
        slicesdir \
        ${img}_orig \
        ${img} \
        ${img%_raw}_nrm_orig \
        ${img%_raw}_nrm
        
    else
        echo "Report exists for ${img%_raw} images..."
    fi
    #         fi
    #     fi
    # fi
done < "$input"
# ------------------------ Reconstruct face in 3D ------------------------ (This part needs to be run from a vncserver session)
BIDSraw=/vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt"
while read image; do
    
    img=${image%.nii*}
    
    change_mon=` ls -l ${image} | awk '{print $6}' `
    change_day=` ls -l ${image} | awk '{print $7}' `
    
    change_mon_nrm=` ls -l ${img%_raw}_nrm.nii.gz | awk '{print $6}' `
    change_day_nrm=` ls -l ${img%_raw}_nrm.nii.gz | awk '{print $7}' `
    # if [ ${change_mon} == "Sep" ] && [ ${change_mon_nrm} == "Sep" ] ; then
    #     if [ ${change_day} == "2" ] || [ ${change_day} == "7" ] || [ ${change_day} == "9" ]; then
    #         if [ ${change_day_nrm} == "2" ] || [ ${change_day_nrm} == "7" ] || [ ${change_day_nrm} == "9" ]; then
    if [ -d ${image%sub*}/slicesdir ]; then
        echo " "
        echo " --------------- "
        echo "3D reconstructing faces for ${img%_raw} images..."
        
        sh /vols/Data/devcog/projects/BOLD/bin/reconstruct_face.sh \
        ${image%sub*} \
        anat
        
    else
        echo "ERROR: No slicesdir directory yet. Need to run slicesdir command first for ${img%_raw} images..."
    fi
    #         fi
    #     fi
    # fi
done < "$input"



# See if all anat folders have slicesdir directories
BIDSraw=/vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt"
while read image; do
    ls -d ${image%sub*}/slicesdir
done < "$input"

# See if all anat slicesdir folders have 3D reconstructed images
BIDSraw=/vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt"
while read image; do
    ls -d ${image%sub*}/slicesdir/*_raw_recon_1.png
done < "$input"

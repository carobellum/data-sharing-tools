#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  move_anat_originals.sh
#
# Description:  Move original json files to seperate folder, to ensure they are not shared
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# bold_dir="/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/"
bold_dir="/vols/Data/devcog/projects/BOLD"
# ------------------------------------------------------------------------------
for sub in ${bold_dir}/sub-*; do
    
    for image in `ls ${sub}/*/*orig* `; do
        if [ ! -f ${bold_dir}/originals/${image##*/} ]; then
            # echo "Moving subject ${sub}..."
            mv ${image} ${bold_dir}/originals/.
        else
            echo "IMAGE ${image} ALREADY EXISTS"
        fi
    done
done

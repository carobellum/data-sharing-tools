#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  move_anat_slicesdirs.sh
#
# Description:  Move original anats (non-defaced) to seperate folder, to ensure they are not shared
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# bold_dir="/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/"
bold_dir="/vols/Data/devcog/projects/BOLD"
# ------------------------------------------------------------------------------
bold_dir="/vols/Data/devcog/projects/BOLD"
for sub in ${bold_dir}/sub-*; do
    echo "Moving subject ${sub}..."
    for directory in `ls -d ${sub}/anat/slicesdir*`; do
        if [ ! -f ${bold_dir}/anat_originals/${directory#*anat/} ]; then
            mv ${directory} ${bold_dir}/anat_originals/${sub##*BOLD/}_${directory#*anat/}
        else
            echo "Directory ${directory} ALREADY EXISTS"
        fi
    done
done

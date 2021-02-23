#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  inspect_defacing_bold.sh
#
# Description:  Inspect defacing on example subject
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Set free parameters (Loop through these for several subjects)
# ------------------------------------------------------------------------------
# Set paths
BIDSraw=/vols/Data/devcog/projects/BOLD
dir_local=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/face_removal/inspect_defacing
# ------------------------------------------------------------------------------
subjects_to_check=" \
636BH \
638BL \
640BT \
648BT \
657BH \
660BH \
666BT \
670BT \
"
# ------------------------------------------------------------------------------
subject=636BH
# for subject in ${subjects_to_check}; do

    input_dir=${BIDSraw}/sub-${subject}
    output_dir=${input_dir}/anat/slicesdir*

    # ---------- Check slicesdir report on cluster ----------
    # cd ${output_dir}
    # firefox ${output_dir}
    # ---------- Copy report: ----------
    sshpass -f /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/jk.txt \
    rsync -rv cn:/${output_dir}/ ${dir_local}/sub-${subject}_slicesdir
     # ---------- Inspect report: ----------
    open ${dir_local}/sub-${subject}_slicesdir/index.html
    # open ${dir_local}/sub-${subject}_slicesdir/*recon*.png
    open ${dir_local}/sub-${subject}_slicesdir/*pydeface*recon*.png


# done



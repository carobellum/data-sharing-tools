#!/bin/bash
#
# Author: Caroline Nettekoven
# FMRIB, Oxford University
# 02.09.2020
#
# ------------------------------------------------------------------------------
# Set paths
BIDSraw=/vols/Data/devcog/projects/BOLD
py_dir=/home/fs0/cnette/.local/bin/
dir_local=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/face_removal/inspect_defacing
# ------------------------ Generate input lists ------------------------
problem_subjects=" \
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
# ------------------------ Make input list ------------------------
cd ${BIDSraw}
rm /vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw_problem_subjects.txt
rm /vols/Data/devcog/projects/BOLD/bin/list_of_funcs_problem_subjects.txt
for subject in ${problem_subjects}; do
    raw_image=${BIDSraw}/sub-${subject}/anat/sub-${subject}_T1w_raw_orig.nii.gz
    all_func_images=`ls sub-${subject}/anat/sub-${subject}_T1w_*_orig.nii.gz`
    all_func_images_defaced=`ls sub-${subject}/anat/sub-${subject}_T1w_???.nii.gz`
    echo "${raw_image}" >> /vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw_problem_subjects.txt
    echo "${all_func_images}" >> /vols/Data/devcog/projects/BOLD/bin/list_of_funcs_problem_subjects.txt
    echo "${all_func_images_defaced}" >> /vols/Data/devcog/projects/BOLD/bin/list_of_funcs_defaced_problem_subjects.txt
done

cat /vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw_problem_subjects.txt
cat /vols/Data/devcog/projects/BOLD/bin/list_of_funcs_problem_subjects.txt

# ------------------------ Deface ------------------------
py_dir=/home/fs0/cnette/.local/bin/
BIDSraw=/vols/Data/devcog/projects/BOLD
cd ${BIDSraw}
for image in `cat ${BIDSraw}/bin/list_of_funcs_problem_subjects.txt`; do
    img=${image%.nii*}

    if [ ! -f ${BIDSraw}/${img}_pydeface.nii.gz ]; then

    ${py_dir}/pydeface \
    --outfile ${BIDSraw}/${img}_pydeface \
    ${image}

    fi
done
# ------------------------ Create defacing report ------------------------
BIDSraw=/vols/Data/devcog/projects/BOLD
for image in `cat ${BIDSraw}/bin/list_of_anats_raw_problem_subjects.txt`; do
    cd ${BIDSraw}

    img=${image%.nii*}
    if [ ! -d ${image%sub*}/slicesdir_`date +%d-%m-%Y` ] && [ -f ${image%sub*}/*nrm_orig_pydeface* ]; then
        echo " "
        echo " --------------- "
        echo "Generating report for ${img%_raw} images..."

        cd ${image%sub*}

        mv slicesdir slicesdir_`date +%d-%m-%Y`

        slicesdir \
        ${img} \
        ${img}_pydeface \
        ${img%_raw*}_nrm_orig \
        ${img%_raw*}_nrm_orig_pydeface

    else
        echo "Report exists for ${img%_raw} images..."
    fi

done

# ------------------------ Reconstruct face in 3D ------------------------ (This part needs to be run from a vncserver session)
BIDSraw=/vols/Data/devcog/projects/BOLD
for image in `cat ${BIDSraw}/bin/list_of_anats_raw_problem_subjects.txt`; do
    cd ${BIDSraw}

    img=${image%.nii*}

    if [ -d ${image%sub*}/slicesdir ] && [ -d ${image%sub*}/slicesdir_`date +%d-%m-%Y` ]; then
        echo " "
        echo " --------------- "
        echo "3D reconstructing faces for ${img%_raw} images..."

        sh /vols/Data/devcog/projects/BOLD/bin/reconstruct_face.sh \
        ${image%sub*} \
        anat

    else
        echo "ERROR: No slicesdir directory yet. Need to run slicesdir command first for ${img%_raw} images..."
    fi

done

# ------------------------ Zip pydeface images ------------------------
py_dir=/home/fs0/cnette/.local/bin/
BIDSraw=/vols/Data/devcog/projects/BOLD
cd ${BIDSraw}
for image in `cat ${BIDSraw}/bin/list_of_funcs_problem_subjects.txt`; do
    img=${image%.nii*}

    if [ ! -f ${BIDSraw}/${img}_pydeface.nii.gz ]; then
        gzip \
        ${BIDSraw}/${img}_pydeface.nii
    else
        echo "${BIDSraw}/${img}_pydeface.nii already zipped"
    fi
done
# ------------------------ Inspect ------------------------
# See if all anat folders have slicesdir directories
BIDSraw=/vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt"
while read image; do
    ls -d ${image%sub*}/slicesdir_*
done < "$input"

# See if all anat slicesdir folders have 3D reconstructed images
BIDSraw=/vols/Data/devcog/projects/BOLD
input="/vols/Data/devcog/projects/BOLD/bin/list_of_anats_raw.txt"
while read image; do
    ls -d ${image%sub*}/slicesdir/*_raw_recon_1.png
done < "$input"

# ------------------------ Rename ------------------------
py_dir=/home/fs0/cnette/.local/bin/
BIDSraw=/vols/Data/devcog/projects/BOLD
cd ${BIDSraw}
for image in `cat ${BIDSraw}/bin/list_of_funcs_defaced_problem_subjects.txt`; do
    img=${image%.nii*}

    if [ -f ${BIDSraw}/${img}_orig_pydeface.nii.gz ]; then

    mv ${img}.nii.gz ${img}_fsl_deface.nii.gz
    mv ${img}_orig_pydeface.nii.gz ${img}.nii.gz

    ls ${img}.nii.gz ${img}_orig_pydeface.nii.gz
    fi
done


# ------------------------ Inspect ------------------------
BIDSraw=/vols/Data/devcog/projects/BOLD
cd ${BIDSraw}
for image in `cat ${BIDSraw}/bin/list_of_funcs_defaced_problem_subjects.txt`; do
    subfolder=${image%anat*}

    fsleyes \
    ${BIDSraw}/${subfolder}/anat/*_acq-raw_T1w.nii.gz -dr 0 300

done
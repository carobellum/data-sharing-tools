cd /vols/Data/devcog/projects/BOLD/
for i in sub*; do
    echo ${i}
    ls ${i}/xjunk
done

touch ~/scratch/BOLD/xjunk_contents_notempty.txt
for i in sub*; do
    echo ${i}
    FILE=""
    DIR="/vols/Data/devcog/projects/BOLD/${i}/xjunk"
    # init
    # look for empty dir
    if [ "$(ls -A $DIR)" ]; then
        echo "Take action $DIR is not Empty"
        echo " " >> ~/scratch/BOLD/xjunk_contents_notempty.txt
        echo ${i} >> ~/scratch/BOLD/xjunk_contents_notempty.txt
        ls ${i}/xjunk >> ~/scratch/BOLD/xjunk_contents_notempty.txt
    else
        echo "$DIR is Empty"
    fi
done

ls sub-*/xjunk > ~/scratch/BOLD/xjunk_contents.txt
cat ~/scratch/BOLD/xjunk_contents.txt

scp cn://home/fs0/cnette/scratch/BOLD/xjunk_contents_notempty.txt .

cat xjunk_contents.txt | grep "sub" > pbcopy

pbcopy < grep "sub" xjunk_contents.txt
pbpaste
cat xjunk_contents.txt | pbcopy


cd /Users/CN/Documents/Projects/BOLD_study/xjunk_cleaning

SUBList="501BT 505BT 512BT 513BT 514BT 516BT 522BT 525BT 533BT 534BT 536BH 540BT 542BL 546BT 554BL 558BL 568BL 569BT 571BL 575BL 581BH 587BH 594BL 598BX 599BH 600BL 606BL 611BT 613BL 621BH 626BL 652BX 653BH 661BT 664BT 675BT"
for SUB in ${SUBList}; do
    echo ${SUB}
    cat Scan_Record_textfile.txt | grep ${SUB} > temp_info.txt
    # cat Scan_Record_textfile.txt | grep ${SUB} >> scan_info_xjunk_subjects.txt
    paste temp_info.txt >> scan_info_xjunk_subjects.txt
done

ssh cn
cd /Volumes/PSY/Research/SpeechBrain/BOLD/
# Files are not in bids format for /vols/Data/devcog/projects/BOLD/sub-501BT/fmap/
# No files whatsoever for /vols/Data/devcog/projects/BOLD/sub-564BL/fmap/


# Copy t1 scans for all t1 problem subjects


# ----------------- Copy T1 scans & xjunk scans for subjects with two T1s ---------------------------
local_workdir=/Users/CN/Documents/Projects/BOLD_study/xjunk_cleaning/inspect
cluster_workdir=/vols/Data/devcog/projects/BOLD/
while read subject; do
    sub=${subject:0:8}
    mkdir ${local_workdir}/${subject}
    
    #  Copy xjunk folder
    echo "Copy xjunx for ${subject}..."
    
    scp -r \
    cn:${cluster_workdir}/${sub}*/xjunk \
    ${local_workdir}/${subject}/.
    
    # Copy anat folder
    echo "Copy anat for ${subject}..."
    scp -r \
    cn:${cluster_workdir}/${sub}*/anat \
    ${local_workdir}/${subject}/.
    
done < ${local_workdir}/copy_t1_subjects.txt

# ButFMRIB1sh0m3:)

# ----------------- Inspect T1s ---------------------------
while read subject; do
    sub=${subject:0:8}
    echo "Inspect ${subject}..."
    fsleyes \
    `ls ${local_workdir}/${subject}/xjunk/*t1*.ni*` \
    `ls ${local_workdir}/${subject}/anat/*nrm*.nii.gz`
done < ${local_workdir}/problem_subjects_t1.txt


# ----------------- Inspect mpm folders on jp ---------------------------
for subject in sub-522BT sub-534BT sub-581BH; do
    # ls /vols/Data/devcog/projects/BOLD/derivatives/${subject}/mpm/*/*
    ls /vols/Data/devcog/projects/BOLD/${subject}/xjunk
done

# ----------------- Inspect Subject with repeated fmri scan ---------------------------
for i in /vols/Data/devcog/projects/BOLD/sub-542BL/xjunk/*.nii.gz; do
    echo $i
    fslinfo $i;
done

cat /vols/Data/devcog/projects/BOLD/sub-542BL/xjunk/sub-542BL_07_BOLD_2p4_MB6_P1_TE30_TR800_AP.json | grep "SeriesNumber"

for i in /vols/Data/devcog/projects/BOLD/sub-542BL/func/*.json; do
    echo $i
    cat $i | grep "SeriesNumber";
done


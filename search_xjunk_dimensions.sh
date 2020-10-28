cd /vols/Data/devcog/projects/BOLD/
cd ..
rm ~/scratch/BOLD/xjunk_matching_dims.txt
touch ~/scratch/BOLD/xjunk_matching_dims.txt
SUBList="501BT 505BT 512BT 513BT 514BT 516BT 522BT 525BT 533BT 534BT 536BH 540BT 542BL 546BT 554BL 558BL 568BL 569BT 571BL 575BL 581BH 587BH 594BL 598BX 599BH 600BL 606BL 611BT 613BL 621BH 626BL 652BX 653BH 661BT 664BT 675BT"
for SUB in ${SUBList}; do
    echo sub-${SUB}
    for i in sub-${SUB}/xjunk/*.nii.gz; do
        DIM4=` fslinfo ${i} | grep "dim4" | head -1 | awk '{print $2}' `
        if [ "$DIM4" == 450 ]; then
            echo ${i} $DIM4 >> ~/scratch/BOLD/xjunk_matching_dims.txt
        elif [ "$DIM4" == 300 ]; then
            echo ${i} $DIM4 >> ~/scratch/BOLD/xjunk_matching_dims.txt
        elif [ "$DIM4" == 600 ]; then
            echo ${i} $DIM4 >> ~/scratch/BOLD/xjunk_matching_dims.txt
        else
            echo Dim is "$DIM4"
        fi
    done
done

# Check resting state dimensions
cd /vols/Data/devcog/projects/BOLD/
for i in sub-*/func/*task-rest_bold.nii.gz; do
    DIM4=` fslinfo ${i} | grep "dim4" | head -1 | awk '{print $2}' `
    if [ ! "$DIM4" == 450 ]; then
        echo ${i} $DIM4
    fi
done


# Check verb gen dimensions
cd /vols/Data/devcog/projects/BOLD/
for i in sub-*/func/*task-verbgen_bold.nii.gz; do
    DIM4=` fslinfo ${i} | grep "dim4" | head -1 | awk '{print $2}' `
    if [ ! "$DIM4" == 325 ]; then
        echo ${i} $DIM4
    fi
done

# Check NWR dimensions
cd /vols/Data/devcog/projects/BOLD/
for i in sub-*/func/*task-nwr_bold.nii.gz; do
    DIM4=` fslinfo ${i} | grep "dim4" | head -1 | awk '{print $2}' `
    if [ ! "$DIM4" == 625 ]; then
        echo ${i} $DIM4
    fi
done

# ------------------------------------------------------------------------------
# Check that SeriesNumber in json file in normal subject folder is GREATER than SeriesNumber for the same file in xjunk folder
# Check NWR dimensions
cd /vols/Data/devcog/projects/BOLD/
for i in sub-*/func/*task-nwr_sbref.json; do
    DIM4=` cat ${i} | grep "SeriesNumber" | head -1 | awk '{print $2}' `
    if [ ! "$DIM4" == 625 ]; then
        echo ${i} $DIM4
    fi
done

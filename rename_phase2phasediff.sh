BIDSraw=/vols/Data/devcog/projects/BOLD
for dir in ${BIDSraw}/sub-*/fmap; do echo $dir;
    cd ${dir}
    for i in *phase.*; do
        mv ${i} ${i%%.*}diff.${i#*.}
    done
done

special_fmap_folders=" \
/vols/Data/devcog/projects/BOLD/sub-501BT/fmap \
/vols/Data/devcog/projects/BOLD/sub-541BT/fmap \
/vols/Data/devcog/projects/BOLD/sub-661BT/fmap \
/vols/Data/devcog/projects/BOLD/sub-564BL/fmap \
"
BIDSraw=/vols/Data/devcog/projects/BOLD
for dir in ${special_fmap_folders}; do echo $dir;
    cd ${dir}
    for i in */*phase.*; do
        echo mv ${i} ${i%%.*}diff.${i#*.}
    done
done
BIDSraw=/vols/Data/devcog/projects/BOLD
for dir in ${BIDSraw}/sub-*/dwi; do echo $dir;
    cd ${dir}
    # for i in *dwi.*; do
    for i in *.*; do
        already_renamed=`echo ${i} | grep "dir"`
        
        if [ -z "$already_renamed" ]; then
            mv ${i} ${i%%acq-*}dir${i#*acq}
        else echo "Already renamed."
        fi
    done
done

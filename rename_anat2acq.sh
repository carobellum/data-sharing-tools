BIDSraw=/vols/Data/devcog/projects/BOLD
for dir in ${BIDSraw}/sub-*/anat; do echo $dir;
    cd ${dir}
    # for i in *dwi.*; do
    for i in *.*; do
        already_renamed=`echo ${i} | grep "acq"`
        
        if [ -z "$already_renamed" ]; then
            
            is_nrm=` echo ${i} | grep "nrm" `
            
            if [ -z "${is_nrm}" ]; then
                mv ${i} ${i%%T1w_*}acq-raw_T1w${i#*_raw}
            else
                mv ${i} ${i%%T1w_*}acq-nrm_T1w${i#*_nrm}
            fi
        else
            echo "Already renamed."
        fi
    done
done
cd ${BIDSraw}

cd /vols/Data/devcog/projects/BOLD
for i in sub*/*.txt; do
    echo $i
    ls ${i%%/R*}/README
    text=${i%%.txt*}
    printf "\n${text##*/}\n" > ${i%%/R*}/README
    cat ${i%%/R*}/README
    rm $i
done


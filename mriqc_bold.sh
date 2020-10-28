#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  mriqc_bold.sh
#
# Description:  Test mriqc on example subjects
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Set free parameters (Loop through these for several subjects)
# ------------------------------------------------------------------------------
# Set paths
BIDSraw=/vols/Data/devcog/projects/BOLD
output_path=/home/fs0/cnette/scratch/BOLD
# ---------------------- Try out on normal subjects ---------------------------------
subjects_to_check=" \
500BT \
501BT \
502BT
"
# ---------------------- Try out on problem subjects ---------------------------------
special_subjects=" \
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
all_included_subjects=" \
500BT \
501BT \
502BT \
503BT \
504BT \
505BT \
506BT \
508BT \
509BT \
510BT \
511BT \
512BT \
513BT \
514BT \
515BT \
516BT \
517BT \
518BT \
519BT \
520BT \
521BT \
522BT \
523BT \
524BT \
525BT \
526BT \
527BT \
528BT \
529BT \
531BT \
532BT \
533BT \
534BT \
535BT \
536BH \
537BT \
538BT \
539BT \
540BT \
541BT \
542BL \
543BT \
544BT \
545BT \
546BT \
547BT \
548BL \
549BT \
550BT \
551BT \
552BL \
554BL \
555BH \
556BL \
557BT \
558BL \
560BH \
561BL \
563BL \
564BL \
565BL \
566BT \
567BL \
568BL \
569BT \
570BL \
571BL \
572BL \
573BL \
574BH \
575BL \
576BL \
577BX \
578BT \
579BL \
580BH \
581BH \
582BH \
583BL \
584BL \
585BH \
586BL \
587BH \
588BH \
589BL \
590BH \
592BL \
593BL \
594BL \
595BL \
596BL \
597BL \
599BH \
600BL \
601BL \
602BL \
603BH \
604BL \
605BL \
606BL \
607BL \
608BL \
609BL \
610BL \
611BT \
612BL \
613BL \
614BH \
615BH \
616BT \
617BL \
618BT \
619BH \
621BH \
622BH \
623BH \
624BT \
625BL \
626BL \
627BH \
628BL \
630BT \
631BT \
632BL \
633BT \
634BH \
635BT \
636BH \
637BT \
638BL \
639BL \
640BT \
641BT \
642BT \
643BL \
644BL \
645BL \
646BL \
647BH \
648BT \
650BT \
651BH \
653BH \
654BL \
655BL \
656BL \
657BH \
659BL \
660BH \
661BT \
662BT \
663BL \
664BT \
665BT \
666BT \
667BT \
668BT \
669BT \
670BT \
672BT \
673BT \
674BL \
675BT \
"

# mriqc --no-sub ${BIDSraw} ${BIDSraw}/mriqc_output_`date +%Y-%m-%d` participant --participant-label ${subjects_to_check}
# fsl_sub -q short.q mriqc --no-sub ${BIDSraw} ${BIDSraw}/mriqc_output_special_subjects_`date +%Y-%m-%d` participant --participant-label ${special_subjects}
fsl_sub -q short.q mriqc --no-sub ${BIDSraw} ${output_path}/mriqc_output_all_subjects_`date +%Y-%m-%d` participant --participant-label ${all_included_subjects}
# ------------- Generate group mriqc report -------------
fsl_sub -q short.q mriqc --no-sub ${BIDSraw} ${output_path}/mriqc_output_group_`date +%Y-%m-%d` group






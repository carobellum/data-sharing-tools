#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  scrub_dicom_headers.sh
#
# Description:  Scrub dicom headers of all potentially identifiable fields.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

dir_local=/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject
sub="sub-650BT"
in=${dir_local}/${sub}/W3T_2018_101_150/

# Anonymize:
# To run GUI: java -jar /Applications/Anonymizer/Anonymizer.jar
# To run command line tool:
java -jar /Applications/DicomAnonymizerTool/DAT.jar -in ${in} -da /Applications/DicomAnonymizerTool/dicom-anonymizer_crn.script
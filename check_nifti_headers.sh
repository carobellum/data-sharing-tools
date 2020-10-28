#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  check_nifti_headers.sh
#
# Description:  Check nifti headers for potentially identifiable information.
#               Script prints the value of the potentially identifiable field.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# bold_dir="/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/"
bold_dir="/vols/Data/devcog/projects/BOLD"
# ------------------------------------------------------------------------------
# Fields that exist in DICOM headers of BOLD study data and could contain identifiable information.
#
# To ensure this list is exhaustive, it was created by
# a)	Searching for all of the fields identified in the Aryanto et al. 2015 paper (Table 1) with spelling variations and with the search function ds.dir() (e.g. ds.dir(‘patient’)
# b)	Outputting all of the dicom fields and adding any additional fields that could contain identifiable information.
#
# dicom_fields='StudyDate  SeriesDate  AcquisitionDate  ContentDate  StudyTime  SeriesTime  AcquisitionTime  ContentTime  AccessionNumber  InstitutionName  InstitutionAddress  ReferringPhysicianName  StationName  InstitutionalDepartmentName  PerformingPhysicianName  PatientName  PatientID  PatientBirthDate  PatientSex  PatientAge  PatientSize  PatientWeight  StudyID  StudyInstanceUID'
dicom_fields_lowercase='studydate  seriesdate  acquisitiondate  contentdate  studytime  seriestime  acquisitiontime  contenttime  accessionnumber  institutionname  institutionaddress  referringphysicianname  stationname  institutionaldepartmentname  performingphysicianname  patientname  patientid  patientbirthdate  patientsex  patientage  patientsize  patientweight  studyid  studyinstanceuid'
# ------------------------------------------------------------------------------


for sub in ${bold_dir}/sub-*; do
    echo "Inspecting subject ${sub}..."
    for i in ${sub}/*/*.nii.gz; do
        for field in ${dicom_fields_lowercase}; do
            fslval $i $field
        done
    done
done

# fslval $i descrip # Command to check example field to show that fslval works

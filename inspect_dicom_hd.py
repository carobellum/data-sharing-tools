#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python3
# ------------------------------------------------------------------------------
# Script name:  inspect_dicom_hd.sh
#
# Description:  Inspect dicom header and identify those fields that could contain
#               potentially identifiable information. Lines that are commented
#               out show fields that do not exist in BOLD study dicom files.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# # source /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env/bin/activate
from pydicom import dcmread
import os
import os.path as op


file = op.join(
    '/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/',
    'sub-650BT/W3T_2018_101_150',
    'BOLD_2p4_MB6_P1_TE30_TR800_AP_2_1',
    'MR.1.3.12.2.1107.5.2.43.66093.2019090715462780951420689'
)
ds = dcmread(file)

# ---- Fields listed in table 1 of Aryanto et al. 2015. ----
ds['StudyDate']
ds['SeriesDate']
ds['AcquisitionDate']
ds['ContentDate']
# ds['OverlayDate']
# ds['CurveDate']
# ds['AcquisitionDatetime']
ds['StudyTime']
ds['SeriesTime']
ds['AcquisitionTime']
ds['ContentTime']
# ds['OverlayTime']
# ds['CurveTime']
ds['AccessionNumber']
ds['InstitutionName']
ds['InstitutionAddress']
ds['ReferringPhysicianName']
# ds['ReferringPhysiciansAddress']
# ds['ReferringPhysiciansTelephone Number']
# ds['ReferringPhysicianIDSequence']
ds['InstitutionalDepartmentName']
# ds['PhysicianOfRecord']
# ds['PhysicianOfRecordIDSequence']
ds['PerformingPhysicianName']
# ds['PerformingPhysicianIDSequence']
# ds['NameOfPhysicianReadingStudy']
# ds['PhysicianReadingStudyIDSequence']
# ds['OperatorsName']
ds['PatientName']
ds['PatientID']
# ds['IssuerOfPatientID']
ds['PatientBirthDate']
# ds['PatientsBirthTime']
ds['PatientSex']
# ds['OtherPatientIDs']
# ds['OtherPatientNames']
# ds['PatientsBirthName']
ds['PatientAge']
# ds['PatientsAddress']
# ds['PatientsMothersBirthName']
# ds['CountryOfResidence']
# ds['RegionOfResidence']
# ds['PatientsTelephoneNumbers']
ds['StudyID']
# ds['CurrentPatientLocation']
# ds['PatientsInstitutionResidence']
# ds['DateTime']
# ds['Date']
# ds['Time']
# ds['PersonName']

# ---- ADDITIONAL Fields that are not listed in in table 1 of Aryanto et al. 2015. ----
ds['PatientSize']
ds['PatientWeight']
ds['StationName']
ds['StudyInstanceUID']

# ---- Test for any additional fields that have not been listed yet
# (And/or go through the list manually) ----

ds.dir("study")
ds.dir("series")
ds.dir("operator")
ds.dir("pat")
ds.dir("phys")

# Display all fields
ds.file_meta

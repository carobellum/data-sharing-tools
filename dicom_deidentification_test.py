#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python3
# ------------------------------------------------------------------------------
# Script name:  dicom_deidentifiaction_test.sh
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

# Dependencies
import os.path as op
import os
from os import walk
from pydicom import dcmread


list_of_id_fields = ['StudyDate', 'SeriesDate', 'AcquisitionDate', 'ContentDate',
                     'StudyTime', 'SeriesTime', 'AcquisitionTime', 'ContentTime',
                     'AccessionNumber', 'InstitutionName', 'InstitutionAddress',
                     'ReferringPhysicianName', 'StationName',
                     'InstitutionalDepartmentName', 'PerformingPhysicianName',
                     'PatientName', 'PatientID', 'PatientBirthDate', 'PatientSex',
                     'PatientAge', 'PatientSize', 'PatientWeight', 'StudyID',
                     'StudyInstanceUID']

mypath = '/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/sub-650BT/W3T_2018_101_150-an/'
for root, dirs, files in os.walk(mypath):
    field_exists = False
    for file in files:
        if file.startswith('MR.'):
            anon_file = op.join(root, file)
            ds = dcmread(anon_file)
            for field in list_of_id_fields:
                if field in ds:
                    print(ds[field])
                    field_exists = True
    if field_exists:
        print('At least one field is not scrubbed in {}', format(root))

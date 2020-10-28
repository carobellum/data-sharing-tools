#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  clean_jsons.py
#
# Description:  Clean json files of potentially identifiable info and add task name.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
import json
from shutil import copyfile
import os.path as op
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


def clean_json_file(json_file_name):
    """Saves copy and cleans json.

    :arg json_file_name:   json file name (e.g. 'sample_file.json')
    """
    # Fields that exist in DICOM headers of BOLD study data and could contain identifiable information.
    #
    # To ensure this list is exhaustive, it was created by
    # a)	Searching for all of the fields identified in the Aryanto et al. 2015 paper (Table 1) with spelling variations and with the search function ds.dir() (e.g. ds.dir(‘patient’)
    # b)	Outputting all of the dicom fields and adding any additional fields that could contain identifiable information.
    #
    empty_these_dicom_field = [
        "InstitutionName", "InstitutionalDepartmentName", "InstitutionAddress", 'StationName', "AcquisitionTime"]
    other_dicom_fields = [
        'StudyDate', 'SeriesDate', 'AcquisitionDate', 'ContentDate', 'StudyTime', 'SeriesTime', 'ContentTime', 'AccessionNumber', 'ReferringPhysicianName',
        'PerformingPhysicianName', 'PatientName', 'PatientID', 'PatientBirthDate', 'PatientSex', 'PatientAge', 'PatientSize', 'PatientWeight', 'StudyID', 'StudyInstanceUID']

    # Open json file
    json_file = open(json_file_name, "r")
    json_object = json.load(json_file)
    json_file.close()

    backup_json_file_name = op.join(
        json_file_name.split('.json')[0] + '_orig.json')

    # Check if file has already been cleaned
    if op.isfile(backup_json_file_name):
        print("File copy already exists. Skipping file: {}".format(
            json_file_name))
        return
    elif json_object["AcquisitionTime"] == "":
        print("Acquisition time field already empty. Skipping file: {}".format(
            json_file_name))
        return

    # Save copy of json file as backup
    copyfile(json_file_name, backup_json_file_name)

    # Empty all fields that contain potentially identifiable information
    for field in empty_these_dicom_field:
        json_object[field] = ""

    # Check for other fields that could contain identifiable information
    for field in other_dicom_fields:
        if field in json_object:
            json_object[field] = ""
            print('Found field: {0}:{1}. Emptied field.'.format(
                field, json_object[field]))

    # Add task name if json object is functional scan
    if 'task' in json_file_name:
        if 'verbgen' in json_file_name:
            json_object["TaskName"] = "verbgen"
        if 'nwr' in json_file_name:
            json_object["TaskName"] = "nwr"
        if 'rest' in json_file_name:
            json_object["TaskName"] = "rest"

    # Add echo times if json object is phasediff scan
    if 'phasediff' in json_file_name:
        json_object["EchoTime1"] = '0.00492'
        json_object["EchoTime2"] = '0.00738'

    # -------- Save json file --------
    json_file = open(json_file_name, "w")
    json.dump(json_object, json_file, indent=4)
    json_file.close()
    print('Cleaned file: {}'.format(json_file_name.split('.json')[-2]))

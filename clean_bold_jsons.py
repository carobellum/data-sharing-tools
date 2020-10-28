#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  clean_bold_jsons.py
#
# Description:  Clean json files from BOLD study of potentially identifiable info and add task name.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

from clean_jsons import clean_json_file
import os.path as op
import os
import glob
import sys
sys.path.insert(1, '/Users/CN/Documents/Projects/BOLD_study_local/bin/')


os.chdir('/Users/CN/Documents/Projects/BOLD_study_local/deidentification/example_subject/')

jsons = glob.glob('sub-*/*/*.json')

for j in jsons:
    clean_json_file(j)

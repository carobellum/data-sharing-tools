#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  clean_bold_jsons.py
#
# Description:  Clean json files from BOLD study of potentially identifiable info, add task name and echo times.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# This next line needs to come after sys.path.insert, but autoformatting keeps moving it up. Run it after line 19.
from clean_jsons import clean_json_file
#
import os.path as op
import os
import glob
import sys
# Path in the next line needs to point to wherever you have put your clean_jsons.py file
sys.path.insert(1, '/vols/Data/devcog/projects/BOLD/bin')


# Change this directory to your folder that contains all the subject folders
os.chdir('/vols/Data/devcog/projects/BOLD/')

# ------- Try example subject and check changes: -------
jsons = glob.glob('testsubject/*/*.json')
for j in jsons:
    # print(j)
    clean_json_file(j)

# ------- Loop across all json files of all subjects: -------
jsons = glob.glob('sub-*/*/*.json')
for j in jsons:
    # print(j)
    clean_json_file(j)

# ------- Loop through all json files of subjects that have another layer in fmap folder: -------
# special_fmap_folders = "/vols/Data/devcog/projects/BOLD/sub-501BT/fmap, /vols/Data/devcog/projects/BOLD/sub-541BT/fmap, /vols/Data/devcog/projects/BOLD/sub-661BT/fmap, /vols/Data/devcog/projects/BOLD/sub-564BL/fmap"
special_jsons = glob.glob('sub-*/*/*/*.json')
for j in special_jsons:
    # print(j)
    clean_json_file(j)

#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  bids_validate_bold.py
#
# Description:  Find unique combinations of variables that could potentially identify subjects in BOLD dataset.
#
# Author:       Caroline Nettekoven, 2020
#               FMRIB, Oxford University
#               15.09.2020
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------ Generate input lists ------------------------
from bids_validator import BIDSValidator
import os
import os.path as op
# ------------------------ Check BIDS ------------------------
BIDSraw = '/vols/Data/devcog/projects/BOLD'
input = "/vols/Data/devcog/projects/BOLD/bin/list_of_anats.txt"

BIDSValidator().is_bids(
    op.join(BIDSraw, 'sub-666BT/anat/sub-666BT_T1w_nrm_orig_pydeface.nii.gz",'))
BIDSValidator().is_bids(
    op.join(BIDSraw, 'sub-666BT_T1w_raw.nii.gz",'))

validate.BIDS(directory, {ignoreWarnings: true}, function(issues, summary) {console.log(issues.errors, issues.warnings)})
# bids-validator /vols/Data/devcog/projects/BOLD


validator = BIDSValidator()
filepaths = ["testsubject/anat/sub-510BT_T1w_nrm.nii.gz", "testsubject/anat/sub-510BT_T1w_nrm_orig.nii.gz", "testsubject/anat/sub-510BT_T1w_raw.nii.gz", "testsubject/anat/sub-510BT_T1w_raw_orig.nii.gz",
             "testsubject_cleaned/anat/sub-510BT_T1w_nrm.nii.gz", "testsubject_cleaned/anat/sub-510BT_T1w_nrm_orig.nii.gz", "testsubject_cleaned/anat/sub-510BT_T1w_raw.nii.gz", "testsubject_cleaned/anat/sub-510BT_T1w_raw_orig.nii.gz", ]
for filepath in filepaths:
    # will print True, and then False
    print(validator.is_bids(op.join(BIDSraw, filepath)))

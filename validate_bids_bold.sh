#! /bin/bash
# ------------------------------------------------------------------------------
# Script name:  validate_bids_bold.sh
#
# Description:  Validate BIDS compatibility of folder to share (BOLD study).
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# On cluster:
module add bids-validator

bids-validator /vols/Data/devcog/projects/BOLD

vi /vols/Data/devcog/projects/BOLD/.bidsignore

for i in */dwi/*.nii; do
    gzip $i;
done
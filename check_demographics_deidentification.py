#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  check_demographics_deidentification.sh
#
# Description:  Script double checks that de-identified demographics yield no unique combinations.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

from find_unique_subjects import find_unique_combinations, show_unique_columns
import os
import os.path as op
import numpy as np
import pandas as pd
from pandas.api.types import CategoricalDtype

import sys
sys.path.insert(0, '/Users/CN/Documents/Projects/BOLD_study_local/bin')


# Get demo
demo_file = (op.join(
    '/Users/CN/Documents/Projects/BOLD_study_local/deidentification/', 'demographics_deidentified.csv'))
demo = pd.read_csv(demo_file)
demo.head()
demo.tail()

# ------------------------------ Find unique subjects --------------------------
demo_columns = ['group', 'age_bin_2', 'sex', 'domhand']
find_unique_combinations(demo, demo_columns)

# --> We're able to share group & sex & domhand & age in 2-year bins without revealing unqiue combinations of these demographic variables
# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------

#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  calc_additional_variables_bold.sh
#
# Description:  Find unique combinations of variables that could potentially identify subjects in BOLD dataset.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

import os
import os.path as op
import numpy as np
import pandas as pd
from pandas.api.types import CategoricalDtype

import sys
sys.path.insert(0, '/Users/CN/Documents/Projects/BOLD_study_local/bin')


# Get df
df_file = op.join(
    '/Users/CN/Documents/Projects/BOLD_study_local/cleaning/behav/swan.csv')
df = pd.read_csv(df_file)
df.head()
df.tail()

# ------------------------------ Exclude subjects ------------------------------
# (apart from 507 & 671, as they did not complete behavioural testing, so aren't in the dataframe anyways)
# Note: 530 also does not appear in behavioural data
excluded_subjects = ['553', '598', '629', '652', '649', '562', '620', '507', '671'
                     '530', '658', '559', '577', '591']

for x in excluded_subjects:
    # if not any(df['code'].str[:3] == x):
    #     print(x)
    df = df.drop(df[df['code'].str[:3] == x].index)


# ------------------------------ Correct levels ------------------------------
df.head()

# ------------------------------ Calculate SWAN ------------------------------
# df['swan_total'] = df.swan_01 + df.swan_02 + df.swan_03 + df.swan_04 + df.swan_05 + df.swan_06 + df.swan_07 + df.swan_08 + \
#     df.swan_09 + df.swan_10 + df.swan_11 + df.swan_12 + df.swan_13 + \
#     df.swan_14 + df.swan_15 + df.swan_16 + df.swan_17 + df.swan_18
# df['swan_average'] = df.swan_total/18


df['adhd_inattention_total'] = df.swan_01 + df.swan_02 + df.swan_03 + df.swan_04 + \
    df.swan_05 + df.swan_06 + df.swan_07 + df.swan_08 + df.swan_09
df['adhd_inattention_average'] = df.adhd_inattention_total / 9

df['adhd_hyper_impuls_total'] = df.swan_10 + df.swan_11 + df.swan_12 + \
    df.swan_13 + df.swan_14 + df.swan_15 + df.swan_16 + df.swan_17 + df.swan_18
df['adhd_hyper_impuls_average'] = df.adhd_hyper_impuls_total / 9

df_add_vars = df[['code', 'adhd_inattention_total',
                  'adhd_inattention_average', 'adhd_hyper_impuls_total', 'adhd_hyper_impuls_average']]

df_add_vars.to_csv(op.join(
    '/Users/CN/Documents/Projects/BOLD_study_local/cleaning/behav/', 'additional_vars.csv'), index=False)

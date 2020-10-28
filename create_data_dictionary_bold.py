#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  create_data_dictionary_bold.sh
#
# Description:  Get info for data dictionary from behavioural variables.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

import os
import os.path as op
import pandas as pd
from pandas.api.types import CategoricalDtype

import sys
sys.path.insert(0, '/Users/CN/Documents/Projects/BOLD_study_local/bin')


# Get df
df_file = op.join(
    '/Users/CN/Documents/Projects/BOLD_study_local/cleaning/behav/data_for_sharing_Sep2020.csv')
df = pd.read_csv(df_file)
df.head()
df.tail()
# [248 rows x 77 columns]

# ------------------------------ Exclude subjects ------------------------------
# (apart from 507 & 671, as they did not complete behavioural testing, so aren't in the dataframe anyways)
# Note: 530 also does not appear in behavioural data
excluded_subjects = ['553', '598', '629', '652', '649', '562', '620', '507', '671'
                     '530', '658', '559', '577', '591']

for x in excluded_subjects:
    # if not any(df['code'].str[:3] == x):
    #     print(x)
    df = df.drop(df[df['code'].str[:3] == x].index)
# [236 rows x 77 columns]

# ------------------------------ Correct levels ------------------------------
df.head()

# code
df.code = df.code.astype('category')

# group
df.final_group = df.final_group.astype('category')
# label_map = {
#     1: 'typ',
#     2: 'dld',
#     3: 'hist'
# }
# df['final_group'] = df['final_group'].map(label_map)
# df.final_group = df.final_group.astype(CategoricalDtype(label_map.values()))

# sex
df.sex = df.sex.astype('category')
# label_map = {
#     1: 'male',
#     2: 'female',
# }
# df['sex'] = df['sex'].map(label_map)
# df.sex = df.sex.astype(CategoricalDtype(label_map.values()))

# domhand
df.domhand = df.domhand.astype('category')
# label_map = {
#     1: 'right',
#     2: 'left',
# }
# df['domhand'] = df['domhand'].map(label_map)
# df.domhand = df.domhand.astype(CategoricalDtype(label_map.values()))

# Age
df = df.rename(columns={'age': 'age_year_mon'})


# ------------------------------ Show range ------------------------------
for col in df.columns:
    if df[col].dtypes == 'int32' or df[col].dtypes == 'float64':
        #
        print('{0} \n{1}-{2}'.format(col,
                                     int(df[col].min()), int(df[col].max())))

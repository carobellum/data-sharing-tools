#! /Users/CN/Documents/Projects/Joystick_Cereb_MRS/bin/mrsi_code/env python
# ------------------------------------------------------------------------------
# Script name:  find_unique_subjects.sh
#
# Description:  Find unique combinations of variables that could potentially identify subjects.
#
# Author:       Caroline Nettekoven, 2020
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

import os
import os.path as op
import numpy as np
import pandas as pd


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Define functions to identify unique combinations of column values


def find_unique_combinations(df, columns):
    df_binned = df.groupby(columns).size(
    ).reset_index().rename(columns={0: 'count'})
    #
    if any(df_binned['count'] == 1):
        print('\nBins with unique combination:\n')
        return df_binned[df_binned['count'] == 1]
    else:
        print('\nNo bin has unique combination.\n')


def show_unique_columns(df, columns):
    #
    result = pd.Series(index=df.index)
    #
    groups = df.groupby(by=columns)
    for _, group in groups:
        is_unique = len(group) == 1
        result.loc[group.index] = is_unique
    #
    # assert not result.isnull().any()
    #
    return result

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Test functions with three examples:
# Unique dataframe (all rows are unique combinations of columns)
# Duplicate dataframe (all rows are duplicate combinations of columns)
# Mixed dataframe (Unique combinations and duplicate combinations of columns)


m = {'sex': ['female', 'female', 'female'],
     'age': [12, 12, 12], 'hand': ['right', 'left', 'right']}
d = {'sex': ['female', 'female', 'female'], 'age': [
    12, 12, 12], 'hand': ['right', 'right', 'right']}
u = {'sex': ['female', 'female', 'male'],
     'age': [12, 14, 12], 'hand': ['right', 'left', 'right']}
un = pd.DataFrame(data=u)
du = pd.DataFrame(data=d)
mi = pd.DataFrame(data=m)
un.head()
du.head()
mi.head()

# # Any duplicated rows?
# un[un.duplicated(['sex', 'age', 'hand'])]
# du[du.duplicated(['sex', 'age', 'hand'])]
# mi[mi.duplicated(['sex', 'age', 'hand'])]

# # Find unique combinations of columns
# s_du = du.groupby(['sex', 'age', 'hand']).size(
# ).reset_index().rename(columns={0: 'count'})

# s_un = un.groupby(['sex', 'age', 'hand']).size(
# ).reset_index().rename(columns={0: 'count'})

# s_mi = mi.groupby(['sex', 'age', 'hand']).size(
# ).reset_index().rename(columns={0: 'count'})

columns = ['sex', 'age', 'hand']

find_unique_combinations(mi, columns)
find_unique_combinations(du, columns)
find_unique_combinations(un, columns)

show_unique_columns(mi, columns)
show_unique_columns(du, columns)
show_unique_columns(un, columns)

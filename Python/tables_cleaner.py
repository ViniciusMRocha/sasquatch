#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 22 09:54:38 2019

@author: nshah & vrocha
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statistics import *


#import all data
tbl_alldata = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.data.1.AllData", delimiter = '\t')
tbl_series = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.series", delimiter = '\t')
tbl_category = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.category", delimiter = '\t')
tbl_characteristics = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.characteristics", delimiter = '\t')
tbl_demographics = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.demographics", delimiter = '\t')
tbl_footnote = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.footnote", delimiter = '\t')
tbl_item = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.item", delimiter = '\t')
tbl_process = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.process", delimiter = '\t')
tbl_subcategory = pd.read_csv("https://download.bls.gov/pub/time.series/cx/cx.subcategory", delimiter = '\t')
tbl_seasonal = pd.read_csv("https://download.bls.gov/pub/time.series/ap/ap.seasonal", delimiter = '\t')


# --------------------- Cleaning tbl_alldata ---------------------
#removing whitespaces
tbl_alldata['series_id'] = tbl_alldata['series_id'].str.strip()

#combining series_id with year to make unique
tbl_alldata['series_id_year'] = tbl_alldata['series_id'] + tbl_alldata['year'].map(str)

#print test
tbl_alldata['series_id_year'][0]

#rearrange columns
tbl_alldata = tbl_alldata [['series_id_year','series_id','year','period','value','footnote_codes']]


# --------------------- Cleaning tbl_characteristics ---------------------
#removing whitespaces
tbl_characteristics['demographics_code'] = tbl_characteristics['demographics_code'].str.strip()
tbl_characteristics['characteristics_code'] = tbl_characteristics['characteristics_code'].str.strip()

# combining demographics_code to characteristics_code to create a primary key
tbl_characteristics['characteristics_demographics_code'] = tbl_characteristics['demographics_code'] + '_' + tbl_characteristics['characteristics_code'].map(str)

#print test
tbl_characteristics['characteristics_demographics_code'] [0]

#rearrange columns
tbl_characteristics = tbl_characteristics[['characteristics_demographics_code', 'demographics_code','characteristics_code','characteristics_text','display_level','selectable','sort_sequence']]



#concat series charcode + demo code
tbl_alldata.to_csv('tbl_alldata.csv', index = False, header = False)
tbl_series.to_csv('tbl_series.csv', index = False)
tbl_category.to_csv('tbl_category.csv', index = False)
tbl_characteristics.to_csv('tbl_characteristics.csv', index = False)
tbl_demographics.to_csv('tbl_demographics.csv', index = False)
tbl_footnote.to_csv('tbl_footnote.csv', index = False)
tbl_item.to_csv('tbl_item.csv', index = False)
tbl_process.to_csv('tbl_process.csv', index = False)
tbl_subcategory.to_csv('tbl_subcategory.csv', index = False)
tbl_seasonal.to_csv('tbl_seasonal.csv', index = False)

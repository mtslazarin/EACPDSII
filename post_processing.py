#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May  4 21:22:24 2019

@author: mtslazarin
"""
#%%
import measureClass as m
from scipy import io
import numpy as np
import pytta
import copy as cp

#%%
medName = 'med-sala_conselhos'

#%% Export all takes to .mat files
m.med_to_mat(medName)
#%% Load all data to workspace
SM,D = m.load(medName)
#%% Apply calibration
calibSig = cp.deepcopy(D.measuredData['calibration']['Mic 2'][0][1])
#calibSig.plot_freq()
#%%
calibdSig = cp.deepcopy(D.measuredData['calibration']['Mic 2'][1][2])
calibdSig.calib_pressure(0,calibSig,1,1000)
#calibdSig.plot_freq()
print(20*np.log10(max(np.abs(calibdSig.freqSignal))/2**(1/2)/2e-5))

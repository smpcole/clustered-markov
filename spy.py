#! /user/bin/python

import matplotlib.pyplot as plt
import sys
import numpy as np

csvpath = sys.argv[1]
outpath = sys.argv[2]

shade =  len(sys.argv) > 3 and sys.argv[3] == 'shade'

A = np.genfromtxt(csvpath, delimiter = ',')

minindices = None
if len(sys.argv) > 4:
    minindices = np.genfromtxt(sys.argv[4], delimiter = ',')
    minindices = np.append(minindices, A.shape[1] + 2)

maxval = np.max(A)

x, y = np.where(A) # Returns indices where A[i, j] != 0

colors = "blue"
if shade:
    numpts = x.size
    colors = np.ones([numpts, 3])

    # Order points by weight
    w = np.zeros([numpts,])
    for i in range(numpts):
        w[i] = A[x[i], y[i]]
    perm = np.argsort(w)
    w, x, y = w[perm], x[perm], y[perm]

    minval = w[0]
    w = w / maxval # Normalize so largest weight is 1

    light = np.array([.875, .875, 1.0])
    dark = np.array([0, 0, 1.0])
    
    for i in range(numpts):
        colors[i, : ] = w[i] * dark + (1 - w[i]) * light 
        
plt.scatter(x, y, marker = '.', c = colors, s = 1, edgecolors = 'face')

if minindices is not None:
    plt.hlines(minindices[0:-1], minindices[0:-1], minindices[1:])
    plt.hlines(minindices[1:], minindices[0:-1], minindices[1:])
    plt.vlines(minindices[0:-1], minindices[0:-1], minindices[1:])
    plt.vlines(minindices[1:], minindices[0:-1], minindices[1:])

plt.savefig(outpath)
print("Output written to %s" % outpath)

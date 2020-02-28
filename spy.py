#! /user/bin/python

import matplotlib.pyplot as plt
import sys
import numpy as np

csvpath = sys.argv[1]
outpath = sys.argv[2]

A = np.genfromtxt(csvpath, delimiter = ',')

maxval = np.max(A)

x, y = np.where(A) # Returns indices where A[i, j] != 0

numpts = x.size
colors = np.zeros([numpts, 3])


for i in range(numpts):
    colors[i, 2] = 1 - A[x[i], y[i]] / maxval

plt.scatter(x, y, marker = '.', c = colors, s = 72, edgecolors = 'face')

plt.savefig(outpath)
print("Output written to %s" % outpath)

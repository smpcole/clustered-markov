#! /user/bin/python

import matplotlib.pyplot as plt
import sys
import numpy as np

csvpath = sys.argv[1]
outpath = sys.argv[2]

shade =  len(sys.argv) > 3 and sys.argv[3] == 'shade'

A = np.genfromtxt(csvpath, delimiter = ',')

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

    for i in range(numpts):
        colors[i, 0 : 2] = 1 - w[i] / maxval

plt.scatter(x, y, marker = '.', c = colors, s = 1, edgecolors = 'face')

plt.savefig(outpath)
print("Output written to %s" % outpath)

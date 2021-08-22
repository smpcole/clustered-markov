#! /user/bin/python

import matplotlib.pyplot as plt
import sys
import numpy as np

csvpath = sys.argv[1]
outpath = sys.argv[2]

shade =  len(sys.argv) > 3 and sys.argv[3] == 'shade'

A = np.genfromtxt(csvpath, delimiter = ',')
m, n = A.shape

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

fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_aspect('equal')
ax.invert_yaxis()
        
plt.scatter(y, x, marker = '.', c = colors, s = 1, edgecolors = 'face')

if len(sys.argv) > 4:
    minindices = np.genfromtxt(sys.argv[4], delimiter = ',')

    if minindices.ndim <= 1 or minindices.shape[0] == 1: 
        minindices = np.array((minindices, minindices))

    if minindices.shape == (2,):
        minindices.shape = (2, 1)

    newcol = np.array((m + 1, n + 1))
    newcol.shape = (2, 1)

    minindices = np.hstack((minindices, newcol))
        
    plt.hlines(minindices[0][0:-1], minindices[1][0:-1], minindices[1][1:])
    plt.hlines(minindices[0][1:], minindices[1][0:-1], minindices[1][1:])
    plt.vlines(minindices[1][0:-1], minindices[0][0:-1], minindices[0][1:])
    plt.vlines(minindices[1][1:], minindices[0][0:-1], minindices[0][1:])


plt.hlines((1, m + 1), (1, 1), (n + 1, n + 1));
plt.vlines((1, n + 1), (1, 1), (m + 1, m + 1));
    
plt.savefig(outpath)
print("Output written to %s" % outpath)

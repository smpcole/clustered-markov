#! /user/bin/python

import matplotlib.pyplot as plt
import sys
import numpy as np

csvpath = sys.argv[1]
outpath = sys.argv[2]

A = np.genfromtxt(csvpath, delimiter = ',')

x, y = np.where(A) # Returns indices where A[i, j] != 0

plt.scatter(x, y)

plt.savefig(outpath)
print("Output written to %s" % outpath)

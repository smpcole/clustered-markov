#! /usr/bin/python

import matplotlib.pyplot as plt
import sys
import numpy as np

csvpath = sys.argv[1]
outpath = sys.argv[2]

Y = np.genfromtxt(csvpath, delimiter = ',')

# If Y is a vector, cast it as a 1 x n matrix
if Y.ndim == 1:
    Y.shape = (1, Y.shape[0])

x = Y[0, :]

for i in range(1, Y.shape[0]):
    plt.plot(x, Y[i])

plt.savefig(outpath)
print("Output written to %s" % outpath)

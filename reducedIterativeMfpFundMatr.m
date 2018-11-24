function R = reducedIterativeMfpFundMatr(k, alpha, beta)
  R = [k + alpha - 1, 1 - beta; k - 1, (1 + alpha) * (1 - beta)] / (k + alpha);
end

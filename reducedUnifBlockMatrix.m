function A = reducedUnifBlockMatrix(k, alpha)
  A = (ones(k) + alpha * eye(k)) / (k + alpha);
end

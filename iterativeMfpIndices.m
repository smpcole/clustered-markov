% Return the (i, j)th index of the first N iterations of iterativeMfp for each (i, j)
% specified in parameter 'indicies'
% indices - m x 2 matrix whose every row specifies an index (i, j) of P
% Y - m x N matrix whose kth row contains the (i, j)th entry of the frist N iterations of
% iterativeMfp, where (i, j) are the indices in row k of indices
function Y = iterativeMfpIndices(P, N, indices)
  n = size(P, 1);
  m = size(indices, 1);
  Y = zeros(m, N);
  M = zeros(n);
  J = ones(n);
  for l = 1 : N
    M = P * (M - diag(diag(M))) + J;
    for k = 1 : m
      i = indices(k, 1);
      j = indices(k, 2);
      Y(k, l) = M(i, j);
    end
  end
end

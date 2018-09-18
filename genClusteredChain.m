% sizes - a row vector of integers representing the sizes of the clusters
% P - an n x n matrix whose (i, j)th entry is drawn uniformly at random from [0, p] if
% i and j are in the same cluster, [0, q] else, then normalized to make it stochastic
function P = genClusteredChain(sizes, p, q)
  n = sum(sizes);
  k = length(sizes);
  P = q * rand(n, n);;
  m = 1;
  for s = sizes
    M = m + s - 1;
    P(m:M, m:M) = p * rand(s, s);
    m = m + s;
  end

  % Normalize row sums
  rowsums = sum(P, 2) * ones(1, n);
  P = P ./ rowsums;
  % Make sure rows actually sum to 1
  diff = ones(n, 1) - sum(P, 2);
  % Add diff to last col of P (should be on the order of machine precision)
  P(:, n) = P(:, n) + diff;
end

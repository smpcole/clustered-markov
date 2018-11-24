% sizes - a row vector of integers representing the sizes of the clusters
% P - an n x n matrix whose (i, j)th entry is sample from distribution intra if
% i and j are in the same cluster, and drom distribution inter otherwise,
% then normalized to make it stochastic
% intra, inter - handles to functions which take (m, n) as parameters and return a m x n
% matrix of samples from a certain distribution
function P = genClusteredChain(sizes, intra, inter)
  if isnumeric(intra)
    intra = unif(intra, intra);
  end
  if isnumeric(inter)
    inter = unif(inter, inter);
  end

  n = sum(sizes);
  k = length(sizes);
  P = double(inter(n, n));
  m = 1;
  for s = sizes
    M = m + s - 1;
    P(m:M, m:M) = intra(s, s);
    m = m + s;
  end

  P = normalize(P);
end

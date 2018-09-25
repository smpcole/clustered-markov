% Choose two random pairs of indices, one from the same cluster and one from different clusters
function indices = randomIndices(sizes)
  n = sum(sizes);
  k = length(sizes);

  % Choose a random cluster
  i = randi(k);
  s = sizes(i);

  % Choose a random state in that cluster
  u1 = sum(sizes(1:i - 1)) + randi(s);

  % Choose a different random state in that cluster
  v1 = sum(sizes(1:i - 1)) + randi(s - 1);
  if v1 >= u1
    v1 = v1 + 1;
  end

  % Choose another random cluster (may be same as first)
  i = randi(k);
  s = sizes(i);

  % Choose a random state in that cluster
  u2 = sum(sizes(1:i - 1)) + randi(s);

  % Choose a random state in a different cluster
  v2 = randi(n - s);
  if v2 > sum(sizes(1:i - 1))
    v2 = v2 + s;
  end

  indices = [u1, v1; u2, v2];

end

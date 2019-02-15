function W0 = twoWayProj(P, threshold)
  n = size(P, 1);
  Q = eye(n) - P;
  [U, S, V] = svd(Q);

  % k = # of singular values close to 0
  k = 0;
  i = n;
  while(i > 0 && S(i, i) <= threshold)
    k = k + 1;
    i = i - 1;
  end

  U0 = U(:, n - k + 1 : n);
  V0 = V(:, n - k + 1 : n);

  W0 = V0 * (transpose(U0) * V0)^-1 * transpose(U0);
end

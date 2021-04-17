function S = dnf(T)
  n = size(T, 1);
  S = T + (eye(n) - T) * ones(n, n) / n;
end

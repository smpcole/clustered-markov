% Normalize X so that all rows sum to 1
function Y = normalize(X)
  n = size(X, 2);
  rowsums = sum(X, 2) * ones(1, n);
  Y = X ./ rowsums;
  %Y = correct(Y);
end

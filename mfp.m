function M = mfp(P)
  n = size(P, 1);
  pi = stationaryDistr(P);
  D = diag(1 ./ pi);
  Z = fundamentalMatrix(P);
  % See Kemeny-Snell Thms. 4.4.7
  M = (eye(n) - Z + ones(n) * diag(diag(Z))) * D;
end

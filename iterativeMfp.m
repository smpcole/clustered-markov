% Compute MFP matrix iteratively according to Kemeny-Snell Thms. 4.4.4 and 4.4.6
function M = iterativeMfp(P, N)
  n = size(P, 1);
  if ~N
    M = zeros(n);
  else
    M = iterativeMfp(P, N - 1);
    M = P * (M - diag(diag(M))) + ones(n);
  end
end

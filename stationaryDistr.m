% Compute the stationary distribution of a regular Markov chain via Gaussian elimination
function pi = stationaryDistr(P)
  n = size(P, 1);
  A = [eye(n) - transpose(P); ones(1, n)];
  pi = linsolve(A, [zeros(n, 1); 1]);
  % Make sure the entries actually add up to 1
  pi = correct(pi);
end


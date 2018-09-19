% Compute the fundamental matrix of a regular Markov chain iteratively
function Z = iterativeFundamentalMatrix(P, N)
  pi = iterativeStationaryDistr(P, N);
  n = size(P, 1);
  A = ones(n, 1) * pi';
  % Z = geometricSeries(P - A, N);
  Z = geometricSeries(P, N) - N * A; % Which of these is better?
end

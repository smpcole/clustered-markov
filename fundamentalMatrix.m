% Compute the fundamental matrix of a regular Markov chain via matrix inversion
function Z = fundamentalMatrix(P)
  n = size(P, 1);
  pi = stationaryDistr(P);
  A = ones(n, 1) * pi';
  Z = (eye(n) - P + A)^-1;
end

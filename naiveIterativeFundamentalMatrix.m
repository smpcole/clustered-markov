% Compute the fundamental matrix of a regular Markov chain iteratively
function Z = naiveIterativeFundamentalMatrix(P, N)
  n = size(P, 1);
  A = P^(2 * N); % Approximate A with a large power of P
  % Z = geometricSeries(P - A, N);
  Z = geometricSeries(P, N) - N * A; % Which of these is better?
end

% Approximate the stationary distribution by raising P to a large power
function pi = iterativeStationaryDistr(P, N)
  A = P^N;
  % All rows of A should be approximately the same, so pick a random row
  n = size(P, 1);
  k = randi(n);
  pi = A(k, 1:n)';
  pi = correct(pi);
end

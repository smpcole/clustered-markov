function K = naiveIterativeKemeny(P, N)
  K = trace(geometricSeries(P, N)) - N - 1;
end

% Compute the sum of the first N terms of the  geometric series P^0 + P^1 + P^2 + ...
% P may be scalar or matrix valued
function W = geometricSeries(P, N)
  n = size(P, 1);
  if N == 0
    W = eye(n);
  else
    W = eye(n) + P * geometricSeries(P, N - 1);
  end
end

function K = naiveIterativeKemeny(P, N)
  K = trace(geometricSeries(P, N)) - N - 1;
end

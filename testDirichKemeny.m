function Y = testDirichKemeny(nmin, nmax, nstep, T)
  x = nmin : nstep : nmax;
  N = length(x);
  Y = zeros(2, N);
  Y(1, :) = x;
  j = 1;
  for n = x
    D = dirichlet(ones(n, n));
    avgK = 0;
    for t = 1 : T
      avgK = avgK + kemeny1(D());
    end
    avgK = avgK / T;
    Y(2, j) = avgK;
    j = j + 1;
  end
  
end

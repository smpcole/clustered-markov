function Y = testCoeffOfErgod(nmin, nmax, nstep, T, output)
  x = nmin : nstep : nmax;
  N = length(x)
  Y = zeros(2, N);
  Y(1, :) = x;
  j = 1;
  for n = x
    D = dirichlet(ones(n, n));
    avgtau = 0;
    B = eye(n) - ones(n, n) / n;
    for t = 1 : T
      avgtau = avgtau + norm(B * D());
    end

    avgtau = avgtau / T;

    Y(2, j) = avgtau;
    
    j = j + 1;
    
  end

  csvwrite(output, Y);

  fprintf('Output written to %s\n', output);
  
end

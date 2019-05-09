function results = testNorms(nmin, nmax, nstep, repetitions, distr, makestochastic, outpath)
  results = 0;

  sizes = nmin : nstep : nmax;

  i = 1;
  results = zeros(5, length(sizes))
  results(1, :) = sizes;
  
  for n = sizes

    svals = zeros(4, 1);
    
    for t = 1 : repetitions
      P = distr(n, n);;
      if makestochastic
	P = normalize(P);
      else
	P = P / n;
      end
      s = svd(P);
      results(2:end, i) = results(2:end, i) + [norm(s); s([1, 2, n])];

    end

    results(2:end, i) = results(2:end, i) / repetitions;
    
    i = i + 1;
    
  end

  csvwrite(outpath, results);

  fprintf('Output written to %s\n', outpath);
  
  
end

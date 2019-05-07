function results = testNorms(nmin, nmax, nstep, repetitions, distr, makestochastic, outpath)
  results = 0;

  sizes = nmin : nstep : nmax;

  i = 1;
  results = zeros(3, length(sizes))
  results(1, :) = sizes;
  
  for n = sizes
    avgl2 = 0;
    avgfrob = 0;
    for t = 1 : repetitions
      P = distr(n, n);;
      if makestochastic
	P = normalize(P);
      else
	P = P / n;
      end
      avgl2 = avgl2 + norm(P);
      avgfrob = avgfrob + norm(P, 'fro');
    end

    avgl2 = avgl2 / repetitions;
    avgfrob = avgfrob / repetitions;

    results(2, i) = avgl2;
    results(3, i) = avgfrob;
    
    i = i + 1;
    
  end

  csvwrite(outpath, results);

  fprintf('Output written to %s\n', outpath);
  
  
end

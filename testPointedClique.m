function results = testPointedClique(k, smin, smax, sstep, outpath)
  svals = smin : sstep : smax;
  N = length(svals);
  results = -ones(3, N);
  results(1, :) = svals;
  for j = 1 : N
    s = svals(j);
    results(2, j) = kemeny1(pointedBlockChain(s, k, 1));
    if s >= k - 1
      results(3, j) = kemeny1(pointedBlockChain(s, k, 2));
    end
    
  end

  csvwrite(outpath, results);
  
end

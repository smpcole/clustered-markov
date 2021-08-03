function results = testSvdAlg(sample, tol, numtrials)
  
  results = {};
  results.distr = sample;
  results.tol = tol;
  results.numtrials = numtrials;
  results.numclusters = [];
  results.weightvec = {};
  results.Wv = {};
  results.W1 = {};
  results.avgdiagWv = [];
  results.avgdiagW1 = [];
  results.mindiagWv = [];
  results.mindiagW1 = [];
  
  for t = 1 : numtrials
    
    T = sample();
    n = size(T, 1);
    [Tperms, perms, minindices, w] = svdAlg(T, tol);

    results.numclusters(end + 1) = length(Tperms);

    results.weightvec{end + 1} = w;
    
    Wv = couplingMatrix(Tperms{end}, minindices{end}, w{end});
    W1 = couplingMatrix(Tperms{end}, minindices{end}, ones(n, 1));

    results.Wv{end + 1} = Wv;
    results.W1{end + 1} = W1;

    results.avgdiagWv(end + 1) = mean(diag(Wv));
    results.avgdiagW1(end + 1) = mean(diag(W1));
    results.mindiagWv(end + 1) = min(diag(Wv));
    results.mindiagW1(end + 1) = min(diag(W1));
    
  end

  results.avgnumclusters = mean(results.numclusters);
  results.avgavgdiagWv = mean(results.avgdiagWv);
  results.avgavgdiagW1 = mean(results.avgdiagW1);
  results.avgmindiagWv = mean(results.mindiagWv);
  results.avgmindiagW1 = mean(results.mindiagW1);

end

function ind = origIndices(perms, minindices)
  % Compute final cumulative permutation - T(q, q) == Tperms{end}
  q  = perms(1, :);
  for i = 1 : size(perms, 1)
    q = q(perms(i, :));
  end
  % Index q(i) of T -> Index i of Tperms{end}

  minindices = [minindices, length(q) + 1];
  ind = {};
  for i = 1 : length(minindices) - 1
    ind{i} = q(minindices(i) : minindices(i + 1) - 1);
  end
end

function results = testSvdAlg(sample, tol, origminindices, numtrials)
  
  results = {};
  results.distr = sample;
  results.tol = tol;
  results.origminindices = origminindices;
  results.numtrials = numtrials;
  results.numclusters = [];
  results.weightvec = {};
  results.Wv = {};
  results.W1 = {};
  results.avgdiagWv = [];
  results.avgdiagW1 = [];
  results.mindiagWv = [];
  results.mindiagW1 = [];
  results.recovered = [];
  results.numerrors = [];
  results.numerrorscorrectnumclusters = [];

  minerrors = Inf;
  maxerrors = -1;
  
  for t = 1 : numtrials
    
    T = sample();
    n = size(T, 1);

    % Randomly permute indices
    p = randperm(n);
    origclusters = {};
    for i = 1 : length(origminindices) - 1;
      origclusters{i} = find(p >= origminindices(i) & p < origminindices(i + 1));
    end
    origclusters{end + 1} = find(p >= origminindices(end));
    Torig = T;
    T = T(p, p);
    
    [Tperms, perms, minindices, w] = svdAlg(T, tol);
    results.numerrors(end + 1) = numerrors(origclusters, perms, minindices{end});
    if length(Tperms) == length(origminindices)
      results.numerrorscorrectnumclusters(end + 1) = results.numerrors(end);
    end
    results.recovered(end + 1) = results.numerrors(end) == 0;

    if results.numerrors(end) > maxerrors
      results.worst = Torig;
      maxerrors = results.numerrors(end);
    end
    if results.numerrors(end) < minerrors
      results.best = Torig;
      minerrors = results.numerrors(end);
    end
    
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

  results.avgnumerrors = sum(results.numerrors) / length(results.numerrors);
  results.avgnumerrorscorrectnumclusters = sum(results.numerrorscorrectnumclusters) / length(results.numerrorscorrectnumclusters);
  results.proprecovered = sum(results.recovered) / length(results.recovered);

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

function y = numerrors(origclusters, perms, minindices)
  clusters = origIndices(perms, minindices);
  
  k = max(length(origclusters), length(clusters));

  % Append empty clusters to smaller set of clusters so that they both have same number of clusters
  for i = length(origclusters) + 1 : k
    origclusters{i} = [];
  end
  for i = length(clusters) + 1 : k
    clusters{i} = [];
  end
  
  C = zeros(k, k);
  for i = 1 : k
    for j = 1 : k
      C(i, j) = length(setxor(origclusters{i}, clusters{j}));
    end
  end

  cvx_begin quiet;

  variable X(k, k) nonnegative;

  minimize trace(C' * X);

  subject to

  X * ones(k, 1) == 1;
  ones(1, k) * X == 1;
  
  cvx_end;

  y = round(cvx_optval / 2);
  
end

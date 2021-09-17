function [Tperm, perm, minindices, incidence, clusters] = projAlg(varargin)

  [T, k] = varargin{1 : 2};
  n = size(T, 1);
  
  incidence = [];

  [U, S, V] = svd(eye(n) - T);
  U = U(:, end - k + 1 : end);
  P = U * U';

  coldiffs = zeros(n, n);
  for i = 1 : n
    for j = 1 : n
      coldiffs(i, j) = norm(P(:, i) - P(:, j));
    end
  end

  if nargin >= 3

    incidence = coldiffs <= varargin{3};
    
  else

    sorteddiffs = sort(reshape(coldiffs, n^2, 1), 'descend');

    mindiff = Inf;
    maxnumtrials = floor(2 * log2(sqrt(n) + 1));
    numtrials = 0;
    for i = 1 : length(sorteddiffs) - 1
      if sorteddiffs(i) >= 2 * sorteddiffs(i + 1)
	numtrials = numtrials + 1;

	mask = coldiffs <= sorteddiffs(i + 1);
	S = min(T, mask);
	diff = norm(T - S, 'fro');
	if diff <= mindiff
	  incidence = mask;
	  mindiff = diff;
	end	
	
	if numtrials >= maxnumtrials
	  break;
	end
      end
    end
    
  end

  clusters = {};
  found = false(n , 1);
  sizes = [];
  perm = [];

  for i = 1 : n

    if ~found(i)

      clusters{end + 1} = find(incidence(i, :));
      found(clusters{end}) = true;
      sizes(end + 1) = length(clusters{end});
      
    end
    
  end

  [sizes, ind] = sort(sizes, 'descend');
  clusters = {clusters{ind}};

  perm = [clusters{:}];
  minindices = [1, 1 + cumsum(sizes(1 : end - 1))];

  Tperm = T(perm, perm);
end

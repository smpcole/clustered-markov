function opt = kmeans1d(x, k)
  n = length(x);
  y = zeros(size(x));
  [x, indices] = sort(x);

  opt = zeros(n, k);

  function err = meansq(i, j)
    err = x(i : j) - mean(x(i : j));
    err = dot(err, err);
  end
  

  for m = 1 : n
    opt(m, 1) = meansq(1, m);
    for l = 2 : k
      % if l >m, then opt(m, l) = 0
      if l < m
	for i = 1 : m
	  err = meansq(i, m);
	  if i == 1
	    opt(m, l) = err;
	  elseif err + opt(i - 1, l - 1) < opt(m, l)
	    opt(m, l) = err + opt(i - 1, l - 1);
	  end
	  
	end
      end
      
    end
  end

  opt = opt(n, k);
  
end

function distr = dirichlet(alpha)

  [m, n] = size(alpha);
  function A = sample()
    A = zeros(m, n);
    for i = 1 : m
      for j = 1 : n
	A(i, j) = gamrnd(alpha(i), 1);
      end
      A(i, :) = A(i, :) / sum(A(i, :));
    end

    A = normalize(A);
    
  end

  distr = @sample;
  
end

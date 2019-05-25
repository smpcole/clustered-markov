function distr = dirichlet(alpha)

  function y = sample()
    K = length(alpha);
    y = zeros(K, 1);
    for i = 1 : K
      y(i) = gamrnd(alpha(i), 1);
    end

    y = y / sum(y);
    
  end

  distr = @sample;
  
end

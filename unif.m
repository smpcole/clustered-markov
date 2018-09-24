% Return a function which generates samples from the uniform distr on [a, b]
function distr = unif(a, b)

  % Return a m x n matrix of samples from the uniform distr on [a, b]
  function X = sample(m, n)
    X = (b - a) * rand(m, n) + a;
  end

  distr = @sample;  
  
end

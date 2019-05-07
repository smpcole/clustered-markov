% Return function which generates samples from an exponential distribution with mean mu
function distr = expDistr(mu)

  function X = sample(m, n)
    X = exprnd(mu, m, n);
  end

  distr = @sample;
  
end

% Return a function which generates samples from a Bernoulli distr with expectation p
function distr = ber(p)

  function X = sample(m, n)
    X = rand(m, n) <= p;
  end

  distr = @sample;

end

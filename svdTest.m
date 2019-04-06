% Generate N n x n random stochastic matrices and return the avg of each singular value
function s = svdTest(n, N)
  s = zeros(n, 1);
  
  for i = 1 : N
    T = genClusteredChain([n], unif(0, 1), unif(0, 1));
    Q = eye(n) - T;
    s = s + svd(Q);
  end

  s = s / N;
  
end

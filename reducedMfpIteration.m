function Mb = reducedMfpIteration(beta)

  function M = reducedIterativeMfp(A, N)
    n = size(A, 1);
    if ~N
      M = zeros(n);
    else
      M = reducedIterativeMfp(A, N - 1);
      M = A * (M - diag(beta * diag(M))) + ones(n);
    end
  end

  Mb = @reducedIterativeMfp;
    
end

function testKMeans(T, sizes)
  k = length(sizes);
  n = sum(sizes);

  TT = T * T';
  [V, D] = eig(TT);
  d = diag(D);
  D = D(n - k + 1 : n, n - k + 1 : n);
  V = V(:, n - k + 1 : n);
  VV = V * V';
  VDV = V * D * V';

  
  km = kmeans(d(1 : n - 1), 2);
  khat = 2;

  for i = n - 2 : -1 : 1
    if km(i) == km(n - 1)
      khat = khat + 1;
    else
      break;
    end
  end
  
  fprintf('No. of clusters detected: %d\n', khat);

  results = ones(4, k);
  matrices = zeros(n, n, 4);
  matrices(:, :, 1) = T;
  matrices(:, :, 2) = TT;
  matrices(:, :, 3) = VV;
  matrices(:, :, 4) = VDV;

  minindex = 1;
  for j = 1 : k
    maxindex = minindex + sizes(j) - 1;

    cluster = zeros(n, 1);
    cluster(minindex : maxindex) = 1;

    for i = 1 : 4

      try
	km = kmeans(matrices(minindex, :, i), 2);
      catch err
	continue;
      end
      km = mod(km, 2);
      for l = 1 : 2
	pcterr = sum(abs(km - cluster)) / n; % Hamming distance / n
	if pcterr < results(i, j)
	  results(i, j) = pcterr;
	end
	km = 1 - km;
      end
      
      
    end    
    
    minindex = maxindex + 1;
  end

  
  fprintf('\nError prop. using T: ');
  disp(results(1, :));
  fprintf('\nError prop. using T * T^T: ');
  disp(results(2, :));
  fprintf('\nError prop. using projector: ');
  disp(results(3, :));
  fprintf('\nError prop. using best rank %d approx.: ', k);
  disp(results(4, :));

  
end

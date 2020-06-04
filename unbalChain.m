function T = unbalChain(sizes, delta)

  m = length(sizes);
  n = sum(sizes);
  T = zeros(n, n);

  minindices = 1 : m;
  for k = 1 : m - 1
    minindices(k + 1) = minindices(k) + sizes(k);
  end
    
  for k = 1 : m

    s = sizes(k);
    blk = zeros(s, n);

    minindex = minindices(k);
    maxindex = minindices(k) + s - 1;

    diagblk = zeros(s, s);
    numnonzerorows = ceil((1 - delta) * s);
    numzerorows = s - numnonzerorows;
    diagblk(1 : numnonzerorows, :) = 1 / s;
    blk(:, minindex : maxindex) = diagblk;

    for i = numnonzerorows + 1 : s
      sgn = (-1)^mod(i - numnonzerorows - 1, 2);
      l = mod(k + sgn * ceil(i / 2) - 1, m) + 1;
      j = minindices(l);
      blk(i, j) = 1;
    end

    T(minindex : maxindex, :) = blk;
    
  end
    
end

function W = couplingMatrix(T, minindices, weightvec)
  n = size(T, 1);
  k = length(minindices);
  W = zeros(k, k);
  minindices(end + 1) = n + 1;
  blk = {};
  for i = 1 : k
    blk{i} = minindices(i) : minindices(i + 1) - 1;
  end
  for i = 1 : k
    for j = 1 : k
      Tblk = T(blk{i}, blk{j});
      rowsums = sum(Tblk, 2);
      W(i, j) = dot(weightvec(blk{i}), rowsums) / sum(weightvec(blk{i}));
    end
  end
end

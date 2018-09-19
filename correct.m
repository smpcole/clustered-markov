% Make sure all rows of a stochastic matrix P actually sum to 1
% If P is a column vector, make sure it sums to 1
function P = correct(P)
  isCol = size(P, 2) == 1;
  if isCol
    P = P';
  end
  [m, n] = size(P);
  for i = 1 : m
    for j = 1 : n
      diff = 1 - sum(P(i, 1 : n));
      if ~diff
	break
      end
      P(i, j) = P(i, j) + diff;
    end
  end
  if isCol % If P was a column vector, convert it back to a column vector
    P = P';
  end
end

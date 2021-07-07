function w = weightVector(T, minindices)
  n = size(T, 1);
  minindices = [minindices, n + 1];
  w = [];
  for i = 1 : length(minindices) - 1
    indices = minindices(i) : minindices(i + 1) - 1;
    m = length(indices);
    [U, S, V] = svd(eye(1) - dnf(T(indices, indices)));
    u = ones(m, 1);
    if m > 1
      u = U(:, m - 1);
    end
    w = [w; abs(u)];
  end
end

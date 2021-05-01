function [Tperms, perms, minindices] = svdAlg(T, tol)

  T = full(T);
  
  Tperms = {};

  [perms, minindices] = svdAlgRec(T, 1, tol, 1 : size(T, 1), {1});

  numiter = size(perms, 1);
  Tperms{1} = T;
  for i = 2 : numiter
    Tperms{i} = Tperms{i - 1}(perms(i, :), perms(i, :));
  end
  
end

function [perms, minindices] = svdAlgRec(T, minindex, tol, perms, minindices)

  T = dnf(T);

  L = laplacian(T);

  [U, S, V] = svd(L);

  n = size(T, 1);

  if n > 1 && S(n - 1, n - 1) < tol

    u = U(:, n - 1);

    I = find(u >= 0);
    J = find(u < 0);

    if length(I) == 0 || length(J) == 0
      return;
    end
    
    P = [I; J];

    perm = 1 : size(perms, 2);
    perm(minindex : minindex - 1 + n) = P + minindex - 1;

    perms = [perms; perm];

    T1 = T(I, I);
    T2 = T(J, J);

    minindices{end + 1} = merge(minindices{end}, [minindex, minindex + size(T1, 1)]);

    [perms, minindices] = svdAlgRec(T1, minindex, tol, perms, minindices);
    [perms, minindices] = svdAlgRec(T2, minindex + size(T1, 1), tol, perms, minindices);
    
  end

end

function z = merge(x, y) % Merge two sorted vectors; assume length(y) == 2
  pre = find(x < y(1));
  mid = find(and(y(1) < x, x < y(2)));
  post = find(x > y(2));
  z = [x(pre), y(1), x(mid), y(2), x(post)];
end


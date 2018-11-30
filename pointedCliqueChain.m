% Generate the transition matrix of a random walk on the graph G obtained as follows:
% Start with k disjoint s-cliques
%
% If type == 1, each clique has a single "point" connected to all other points;
% thus, the points form a k-clique.
%
% If type == 2, each clique has k - 1 points, each of which is connected to exactly
% one point in another clique, with exactly one edge between points in any pair of cliques;
% thus, the points form a perfect matching on k(k - 1) vertices.
%
function P = pointedCliqueChain(s, k, type)
  n = s * k;

  if type == 1
    E = zeros(s);
    E(1, 1) = 1;
    P = normalize(kron(ones(k), E) + kron(eye(k), ones(s) - E));

  elseif type == 2
    P = kron(eye(k), ones(s));

    for i = 1 : k
      minu = s * (i - 1) + 1;
      for j = i + 1 : k

	minv = s * (j - 1) + 1;
	u = j - 1;
	v = i;

	u = minu + u - 1;
	v = minv + v - 1;

	P(u, v) = 1;
	P(v, u) = 1;

      end

    end

    P = normalize(P);

  else

    error('Error: invalid type (must be 1 or 2)', type);

  end
  
end

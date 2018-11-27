% Generate the transition matrix of a random walk on the graph G obtained as follows:
% Start with k disjoint s-cliques
% Designate a vertex in each clique
% Connect all the designated vertices, forming a k-clique
function P = cliquePartitionWalk(s, k)
  n = s * k;
  E = zeros(s);
  E(1, 1) = 1;
  P = normalize(kron(ones(k), E) + kron(eye(k), ones(s) - E));
end

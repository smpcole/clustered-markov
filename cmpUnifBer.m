function [udiff, bdiff] = cmpUnifBer(sizes, p, q, N, outpath)
  P = genClusteredChain(sizes, 2 * p, 2 * q);
  Q = genClusteredChain(sizes, 2 * p, ber(q));

  indices = randomIndices(sizes);

  Y = [iterativeMfpIndices(P, N, indices); iterativeMfpIndices(Q, N, indices)];

  csvwrite(outpath, Y);

  fprintf('Output written to %s\n', outpath);

  udiff = Y(2, N) - Y(1, N);
  bdiff = Y(4, N) - Y(3, N);

end

function Y = testIterativeMfp(sizes, intra, inter, N, outpath)
  
  P = genClusteredChain(sizes, intra, inter);

  indices = randomIndices(sizes);

  Y = [1 : N; iterativeMfpIndices(P, N, indices)];

  csvwrite(outpath, Y);

  fprintf('Output written to %s\n', outpath);
  
end

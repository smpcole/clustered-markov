function plotIterativeMfp(P, N, indices)
    Y = iterativeMfpIndices(P, N, indices);
    plot(Y');
end
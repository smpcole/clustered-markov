function K = kemeny1(P)
    Z = fundamentalMatrix(P);
    K = trace(Z) - 1;
end


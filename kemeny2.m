function K = kemeny2(P)
    M = mfp(P);
    pi = stationaryDistr(P);
    
    % Kemeny's constant will be same regardless of i, so choose i randomly
    i = randi(size(P, 1));
    K = M(i, :) * pi;
end
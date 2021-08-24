addpath('../..');

numerr = [0, 5, 13, 37];
tol = .6;
origminindices = [1, 101, 201, 251];

for e = numerr
  load(sprintf('ber_%derr_95_05_6.mat', e));
  p = randperm(size(Torig, 1));
  T = Torig(p, p);
  [Tperms, perms, minindices] = svdAlg(T, tol);
  Tperms{end + 1} = Torig;
  minindices{end + 1} = origminindices;
  for i = 1 : length(Tperms)
    writematrix(Tperms{i}, sprintf('%derr_%d.csv', e, i));
    writematrix(minindices{i}, sprintf('minindices_%derr_%d.csv', e, i));
  end
end

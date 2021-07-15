function [Dperms, cumperms, mode1, mode2, minindices1, minindices2] = twomode(Tperms, perms, minindices, mode1size)
  Dperms = {};
  cumperms = perms;
  mode1 = [];
  mode2 = [];
  minindicies1 = {};
  minindices2 = {};
  for i = 1 : length(Tperms)
    if i > 1
      cumperms(i, :) = cumperms(i - 1, perms(i, :));
    end
    mode1(i, :) = find(cumperms(i, :) <= mode1size);
    mode2(i, :) = find(cumperms(i, :) > mode1size);
    Dperms{i} = Tperms{i}(mode1(i, :), mode2(i, :));

    minindices{i}(end + 1) = size(Tperms{i}, 1);
    minindices1{i} = 1;
    minindices2{i} = 1;
    for j = 2 : length(minindices{i}) - 1;
      minindices1{i}(j) = minindices1{i}(j - 1) + sum(mode1(i, :) >= minindices{i}(j - 1) & mode1(i, :) < minindices{i}(j));
      minindices2{i}(j) = minindices2{i}(j - 1) + sum(mode2(i, :) >= minindices{i}(j - 1) & mode2(i, :) < minindices{i}(j));
    end

  end
end

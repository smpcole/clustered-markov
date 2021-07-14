function [Dperms, cumperms, mode1, mode2] = twomode(Tperms, perms, mode1size)
  Dperms = {};
  cumperms = perms;
  mode1 = [];
  mode2 = [];
  for i = 1 : length(Tperms)
    if i > 1
      cumperms(i, :) = cumperms(i - 1, perms(i, :));
    end
    mode1(i, :) = find(cumperms(i, :) <= mode1size);
    mode2(i, :) = find(cumperms(i, :) > mode1size);
    Dperms{i} = Tperms{i}(mode1(i, :), mode2(i, :));
  end
end

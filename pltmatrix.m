function pltmatrix(A, outpath, remoteusr, remotedir, port, shade)

  csvpath = sprintf('%d.csv', randi(10000));

  csvwrite(csvpath, A);

  if shade
    shade = 'shade';
  else
    shade = '';
  end
  
  cmd = sprintf('python spy.py %s %s %s', csvpath, outpath, shade);

  system(cmd);

  delete(csvpath);

  cmd = sprintf('scp -P %d %s %s@localhost:%s', port, outpath, remoteusr, remotedir);
  disp(cmd);

  system(cmd);

end

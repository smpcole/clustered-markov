function pltmatrix(A, outpath, remoteusr, remotedir, port)

  csvpath = sprintf('%d.csv', randi(10000));

  csvwrite(csvpath, A);

  cmd = sprintf('python spy.py %s %s', csvpath, outpath);

  system(cmd);

  delete(csvpath);

  cmd = sprintf('scp -P %d %s %s@localhost:%s', port, outpath, remoteusr, remotedir);
  disp(cmd);

  system(cmd);

end

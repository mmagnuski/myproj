% proj_OlgaN170


PTH = 'D:\Dropbox\CURRENT PROJECTS\N170 Olga';
dtpth = 'D:\DATA\N170 Olga';
fls = dir(fullfile(dtpth, '*.set'));

% add paths
addpath(fullfile(PTH, 'code'));
addpath('D:\DATA\maskitsweet\');
addpath('D:\DATA\GIT\braintools\');

% init braintools
braintools;
eegDb;
eeg_path('add');

% set of anonymous funs:
cnt = @(x) x(1):x(2);
loads = @(x) pop_loadset(fullfile(dtpth, x));


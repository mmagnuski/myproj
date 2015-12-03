% proj_OlgaN170

btls = {'D:\DATA\GIT\braintools\', 'E:\Programy\braintools'};
exists_dir = cellfun(@(x) isdir(x), btls);
btls = btls(exists_dir);
btls = btls{1};
addpath(btls);

% init braintools, eegDb and eeglab
braintools;
eegDb;
eeg_path('add');

% set of anonymous funs:
cnt = @(x) x(1):x(2);
loads = @(x) pop_loadset(fullfile(dtpth, x));


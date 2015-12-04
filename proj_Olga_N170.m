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

p = project();

p.pth('root', {'D:\Dropbox\CURRENT PROJECTS\N170 Olga', ...
    'C:\Users\Ola\Dropbox\N170 Olga'});
p.pth('code', fullfile(p('root'), 'code'));
p.pth('data', fullfile(p('root'), 'SET'));

fls = dir(fullfile(p('data'), '*.set'));

% add paths
p.addp('code');


% set of anonymous funs:
cnt = @(x) x(1):x(2);
dtpth = p('data');
loads = @(x) pop_loadset(fullfile(dtpth, x));


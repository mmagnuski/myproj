% add path to toolboxes:
fprintf('add toolboxes...\n');
eegDb();
addpath('D:\DATA\GIT\braintools\');
braintools;
addpath('D:\DATA\maskitsweet\');
eeg_path('add');

% init project instance
proj = project();
proj.protect({'EEG', 'ICAw'});
proj.pth('base', ['D:\Dropbox\DANE\SarenkaData',...
    '\porzadki liniowe 2014\']);
proj.pth('data', fullfile(proj.pth('base'), ...
    'SET', 'baseline'));
proj.pth('db', fullfile(proj.pth('base'), 'bazy'));
proj.pth('code', fullfile(proj.pth('base'), ...
    'scripts'));
proj.pth('fig', fullfile(proj.pth('base'), 'figures'));

proj.addp('code');

% path variables
PTH = 'D:\Dropbox\CURRENT PROJECTS\alfa depresja';

% add paths
fprintf('adding paths...\n');
addpath(PTH);
addpath('');

% load workspace and database
fprintf('loading workspace...\n');
load(fullfile(PTH, 'workspace.mat'));
fprintf('done.\n');
try
    db_start(proj.pth('db'));
catch
    ICAw_start(proj.pth('db'));
end

% clean up filepath field and add additional path
fun = @(x) fastif(iscell(x.filepath), unique(x.filepath), x.filepath);
try
    db = db_apply(db, 'filepath', fun);
    db = db_addpath(db, proj.pth('data'));
catch
    db = db_apply(ICAw, 'filepath', fun);
    db = ICAw_addpath(db, proj.pth('data'));
end

% read  PCA depression factor
fprintf('loading behavioral scores...\n');
read_factor_scores;

% read freqs
load(fullfile(proj.pth('base'), 'analysis\baseline_freqs.mat'));

% remove subjects that cannot be used
rem = isnan(dep_fac) | cellfun(@isempty, freqs);
dep_fac(rem) = [];
freqs(rem) = [];

% read depression bdi scores (uses rem created above)
read_bdi_scores;

% recover a file (for tests etc.)
r = randi(length(db), 1);
fprintf('recovering random EEG from database (r=%d)\n', r);
EEG = recoverEEG(db, r, 'local', 'interp');

% read stat
fprintf('reading stat results...\n');
load(fullfile(proj.pth('base'), 'analysis', ...
    'elec_asym_stat.mat'));

% useful anonymous functions
cnt = @(x) x(1):x(end);

% clear up
clear fun
% proj DiamDec:

% add packages
eegDb;
fprintf('adding paths to braintools...\n');
tmp_pth = get_valid_path({'D:\DATA\GIT\braintools', ...
	'E:\Programy\braintools'});
addpath(tmp_pth);
braintools;

% set up project
p = project();
PTH = {'D:\Dropbox\CURRENT PROJECTS\DiamDec 2013-2014\', ...
	'E:\PROJ\DiamDec\'};
p.pth('proj', PTH);


temp = {'D:\Dropbox\CURRENT PROJECTS\Sarenka\Modele', ...
    'C:\Users\Ola\Dropbox\Sarenka\Modele'};
p.pth('mdl', temp);

% add some other paths:
addpath(genpath(fullfile(p('proj'), 'scripts')));
addpath(genpath(fullfile(p('proj'), 'code')));

try
addp = ['D:\Dropbox\CURRENT PROJECTS\Decyzyjne ',...
    'Diamenty\WYCZYSZCZONE DANE\'];
db_start(PTH);

fprintf('reformatting the database...\n');

% update to new format
db = db_updatetonewformat(db);

% accept components marked for rejection
db = db_apply_icarem(db);

% changing the filepath:
opt.filepath = addp;

% make sure epoching is correct:
opt.epoch = db(1).epoch;
opt.epoch.limits = [-0.2, 0.7];
db = db_copybase(db, opt);

% get an EEG
fprintf('recovering EEG...\n');
EEG = recoverEEG(db, 12, 'interp', 'local');

% copy elec pos to db:
for r = 1:length(db)
    db(r).datainfo.chanlocs = EEG.chanlocs;
end
catch
    EEG = pop_loadset(['C:\Users\Ola\Dropbox\', ...
        'N170 Olga\SET\faces_g_46.set']);
end

% this is old, not used now
% fprintf('loading stat and alldata...\n');
% D_load

% load trialinfo and 
p.pth('res', fullfile(p('mdl'), 'results03'));
p.cd('res');
trial_info = dataset('file', 'TrialInfo.csv', 'Delimiter', ',');
load('eeg.mat');
load('stat - fin model (absDiff x strat + cueNum x strat).mat');

% protect variables
p.protect({'p', 'db', 'EEG', 'PTH', 'stat', 'trial_info', ...
	'alldata'});
% p.cl(); % <- this doesn't work so well...
clear opt r temp* addp

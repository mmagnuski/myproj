% proj DiamDec:

% add packages
eegDb;
fprintf('adding paths to braintools and maskitsweet...\n');
addpath('D:\DATA\maskitsweet\');
addpath('D:\DATA\GIT\braintools');
braintools;

% set up project
p = project();
PTH = 'D:\Dropbox\CURRENT PROJECTS\DiamDec 2013-2014\';
p.pth('proj', PTH);
addp = ['D:\Dropbox\CURRENT PROJECTS\Decyzyjne ',...
    'Diamenty\WYCZYSZCZONE DANE\'];
temp = {'D:\Dropbox\CURRENT PROJECTS\Sarenka\Modele', ...
    'C:\Users\Ola\Dropbox\Sarenka\Modele'};
p.pth('mdl', temp);

% add some other paths:
addpath(genpath(fullfile(p('proj'), 'scripts')));

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

fprintf('loading stat and alldata...\n');
D_load

% protect variables
p.protect({'p', 'db', 'EEG', 'PTH', 'tri', 'alldata'});
% p.cl();
clear opt r temp addp

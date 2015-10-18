% proj DiamDec:
PTH = 'D:\Dropbox\CURRENT PROJECTS\DiamDec 2013-2014\';
addp = ['D:\Dropbox\CURRENT PROJECTS\Decyzyjne ',...
    'Diamenty\WYCZYSZCZONE DANE\'];

% setup eegDb
eegDb_setup; 
ICAw_start(PTH);

% add some other paths:
addpath(genpath([PTH,'scripts\']));
addpath('D:\DATA\eegDb historical and other\TESTING\fastplot\');
cd('D:\DATA\eegDb historical and other\TESTING\fastplot\');

% update to new format
ICAw = ICAw_updatetonewformat(ICAw);

% accept components marked for rejection
ICAw = ICAw_apply_icarem(ICAw);

% changing the filepath:
opt.filepath = addp;

% make sure epoching is correct:
opt.epoch = ICAw(1).epoch;
opt.epoch.limits = [-0.2, 0.7];
ICAw = ICAw_copybase(ICAw, opt);

% get an EEG
fprintf('reocvering EEG...\n');
EEG = recoverEEG(ICAw, 12, 'interp', 'local');

% copy elec pos to ICAw:
for r = 1:length(ICAw)
    ICAw(r).datainfo.chanlocs = EEG.chanlocs;
end
% clear up
clear opt addp r

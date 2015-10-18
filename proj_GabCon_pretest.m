% project GabCon 2015 - pretest

% setup paths
eegDb_setup();
eeg_path('add');

% project location
PTH = ['D:\DATA\GabCon 2014-2015\Pretests\',...
    'EEG pretest - Miko\'];

% channel location file
chanlocf = ['D:\\Dropbox\\DANE\\LabStuff\\EasyCap info',...
    '\\Chan Locs\\EasyCap_locs_inv.txt'];

% add code to path
addpath(['D:\DATA\GabCon 2014-2015\Pretests\',...
    'EEG pretest - Miko\code']);

% read behavioral data
[~, ~, beh] = xlsread(fullfile(PTH, 'behdata', '23.xls'));
beh = beh(:,2:end);
beh = cell2dataset(beh);

% read in database
ICAw_start(fullfile(PTH, 'db'));
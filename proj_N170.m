% check eegDb paths for this project
if isempty(which('db_gui'))
    eegDb();
end

% add path to project relevant files
PTH = 'D:\DATA\CAT N170 EEG\';
addpath([PTH,'scripts']);

% load database:
db_start(fullfile(PTH, 'db'));

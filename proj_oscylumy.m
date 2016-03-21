% setup
% -----
eegDb
braintools
eeg_path('add'); % seems that eeg_path is not in braintools, need to add!

p = project;
p.pth('proj', {'E:\PROJ\oscylumy', 'D:\proj\oscylumy'});
p.pth('data', {'D:\DATA\PAC', 'D:\DANE\PAC', 'E:\PROJ\PAC'});

p.pth('set', 'SET', 'data');
p.pth('pac', 'raven pac', 'data');
p.pth('code', 'code\mat', 'proj');
p.pth('fig', 'fig', 'proj');

% add path to code files
p.addp('code');
% move to oscylumy
p.cd('proj');

% load eeg
% --------
fls = dir(fullfile(p('set'), '*.set'));
EEG = pop_loadset(fullfile(p('set'), fls(1).name));
EEG = adapt_set_to_biosemi32(EEG);

% pick only some channels
pick_chans = 3:34;
EEG = pick_channels(EEG, pick_chans);


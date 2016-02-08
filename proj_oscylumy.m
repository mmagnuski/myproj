% setup
% -----
braintools
eeg_path('add');

p = project;
p.pth('proj', {'E:\PROJ\oscylumy'});
p.pth('data', {'D:\DATA\PAC', 'E:\PROJ\PAC'});

p.pth('set', 'SET', 'data');
p.pth('pac', 'raven pac', 'data');
p.pth('code', 'code\mat', 'proj');

% add path to code files
p.addp('code');

% load eeg
% --------
fls = dir(fullfile(p('set'), '*.set'));
EEG = pop_loadset(fullfile(p('set'), fls(1).name));
EEG = adapt_set_to_biosemi32(EEG);

% pick only some channels
pick_chans = 3:34;
EEG = pick_channels(EEG, pick_chans);


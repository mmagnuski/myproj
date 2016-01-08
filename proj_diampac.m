% myproj pacdiam
braintools
eegDb

p = project;
p.pth('root', {'C:\Users\Ola\Dropbox\PAC & DIAMENTY', ...
	'D:\Dropbox\PAC & DIAMENTY'});
p.pth('db', fullfile(p('root'), 'db'));
p.pth('data', fullfile(p('root'), 'SET'));

db_start(p('db'));
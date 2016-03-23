% myproj pacdiam
braintools
eegDb

p = project;
p.pth('root', {'C:\Users\Ola\Dropbox\PAC & DIAMENTY', ...
	'D:\Dropbox\PAC & DIAMENTY'});
p.pth('db', 'db', 'root');
p.pth('data', 'SET', 'root');
p.pth('code', 'code', 'root')

addpath(p('code'));
db_start(p('db'));
% paths
eegDb
pth = get_valid_path({'D:\DATA\GIT\braintools', ...
	'E:\Programy\braintools'});
addpath(pth);
braintools

p = project();
p.pth('tfr', 'E:\PROJ\Vron\tfr');
p.pth('code', {['D:\Dropbox\CURRENT PROJECTS\',...
    'Sarenka\Vron\code'], 'E:\PROJ\Vron\code'});
p.pth('res', {['D:\Dropbox\CURRENT PROJECTS\',...
    'Sarenka\Vron\res'], 'E:\PROJ\Vron\res'});

p.addp('code');
try
    p.cd('tfr');
    fls = dir('*.mat');
end

msk = @(tfr, chan) maskitsweet(squeeze(...
    tfr.powspctrm(chan,:, :)), [], ...
    'Freq', tfr.freq, 'Time', tfr.time);
msk_log = @(tfr, chan) maskitsweet(log(squeeze(...
    tfr.powspctrm(chan,:, :))), [], ...
    'Freq', tfr.freq, 'Time', tfr.time);
cnt = @(x) x(1):x(2);

msk_stat = @(stat, clst, chan) maskitsweet(...
    squeeze(stat.stat(chan,:,:)), ...
    squeeze(stat.negclusterslabelmat(chan,:,:)) == clst, ...
    'Time', stat.time, 'Freq', stat.freq, 'MapEdge', 'max');

% read stat
p.cd('res');
load('step 3.mat');


% plotting middle fft
% iflog = true;
% figure; hold on;
% col = repmat(linspace(1, 0.5, 6)', [1, 3]);
% for i = 1:6
%     sig = squeeze(...
%     tfr{i}.powspctrm(chan, :, 12));
%     if iflog
%         sig = log(sig);
%     end
% plot(tfr{i}.freq, sig, ...
%     'Color', col(i, :), 'LineWidth', 2);
% end


% 
% clst1 = stat.negclusterslabelmat == 1;
% sum(clst1(:))
% chn_clst1 = sum(sum(clst1,3), 2);
% plot(chn_clst1)
% 
% [~, chn_ord] = sort(chn_clst1);
% chn_ord = flipud(chn_ord);
% 
% msk_stat(stat, 1, 24);


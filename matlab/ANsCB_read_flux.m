% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
fname = 'flux_0';
fnamelong = [indir,'/',fname,'.dat'];
f = importdata(fnamelong,' ',2);
td1 = f.data;
for i = 1:numel(f.colheaders)
    header{i} = f.colheaders{i}(2:end); % read headers from 2nd letter
end
plnames = {'KO13' 'KO40' 'KO53' 'KO97' 'KO100' 'KO116B' 'KO139' 'KO139A' 'KO139B' 'KO197A' 'KO197B' 'KO197B'};
cvec       = {    'r'      'r'         'r'        'r'       'b'         'r'            'r'          'b'           'b'           'b'            'b'          'b'};
nrows = 3;
ncols = 4;
%% Plot mixing ratios
xend = 3600*24;%length(td1);
fig=figure;
for isub = 1:numel(plnames)
    j = find(ismember(header,plnames{isub}));
    subplot(nrows,ncols,isub); plot(td1(:,j),'LineWidth',2,'Color',cvec{isub}); title(header{j});
end
faxes = findobj(fig,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',9)
    ylabel(faxes(i),'number of CB','FontSize',9)
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/',fname,'_pic','.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
fname = 'chem_1_02';
fnamelong = [indir,'/',fname,'.dat'];
f = importdata(fnamelong,' ',2);
td1 = f.data;
for i = 1:numel(f.colheaders)
    header{i} = f.colheaders{i}(2:end); % read headers from 2nd letter
end
plnames = {'O3' 'O1D' 'OH' 'NO' 'NO2' 'HO2' 'H2O2' 'CO' 'CH4' 'C2H6' 'CH3O' 'CH3O2' 'C2H5O' 'C2H5O2' 'HCHO' 'CH3NO3' 'C2H5NO3'};
% cvec   = {'r'      'r'      'r'      'r'       'b'     'r'      'r'        'b'         'b'         'b'           'b'         'b'        'r'      'r'     'b'     'b'          'b' 'b'};
nrows = 4;
ncols = 5;
%% Plot mixing ratios
xend = 3600*24;%length(td1);
fig=figure;
for isub = 1:numel(plnames)
    j = find(ismember(header,plnames{isub}));
    subplot(nrows,ncols,isub); plot(td1(:,j),'LineWidth',2,'Color','b'); title(header{j});
%     subplot(nrows,ncols,isub); plot(td1(:,j),'LineWidth',2,'Color',cvec{isub}); title(header{j});
end
faxes = findobj(fig,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',9)
    ylabel(faxes(i),'ppb','FontSize',9)
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/',fname,'.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
fname = 'chem_0';
fnamelong = [indir,'/',fname,'.dat'];
f = importdata(fnamelong,' ',2);
td1 = f.data;
for i = 1:numel(f.colheaders)
    header{i} = f.colheaders{i}(2:end); % read headers from 2nd letter
end
plnames = {'O3' 'HO' 'HO2' 'H2O2' 'NO' 'NO2' 'HONO2' 'HCO' 'CH3O2' 'CH3OOH' 'HCHO' 'CO'};
cvec       = {'r'      'r'      'r'        'r'    'r'      'r'         'b'          'b'         'b'         'b'           'r'      'r'};
nrows = 3;
ncols = 4;
%% Calculate number of carbon bonds,
% i.e. fluxes through reactions where carbon bond is broken and peroxy radical is
% produced, namely:
% HCO+O2 = CO+HO2
% CH3O+O2 = HCHO+HO2
% CB = td1(:,13) + td1(:,14);
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
    ylabel(faxes(i),'ppb','FontSize',9)
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/',fname,'_pic_2_RH80_no100_no139','.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
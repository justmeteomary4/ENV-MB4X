% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
exp = '1_02';
fname0 = 'chem_';
fname1 = 'chem_inorg_'; fname2 = 'chem_organ_'; fname3 = 'chem_orgnit_';
fnamelong1 = [indir,'/',fname1,exp,'.dat'];
fnamelong2 = [indir,'/',fname2,exp,'.dat'];
fnamelong3 = [indir,'/',fname3,exp,'.dat'];
f1 = importdata(fnamelong1,' ',2);
f2 = importdata(fnamelong2,' ',2);
f3 = importdata(fnamelong3,' ',2);
rd1 = f1.data; rd2 = f2.data; rd3 = f3.data;
td = horzcat(rd1,rd2,rd3(1:end-1,:));
%% Plot mixing ratios
% O3 O1D OH NO NO2 HO2 H2O2 CO CH4 C2H6 CH3O CH3O2 C2H5O C2H5O2 HCHO CH3NO3 C2H5NO3
plnames = {'O3' 'O1D' 'OH' 'NO' 'NO2' 'HO2' 'H2O2' 'CO' 'CH4' 'C2H6' 'CH3O' 'CH3O2' 'C2H5O' 'C2H5O2' 'HCHO' 'CH3NO3' 'C2H5NO3'};
nrows = 4;
ncols = 5;
xend = size(td,1);
fig=figure;
for isub = 1:numel(plnames)
    subplot(nrows,ncols,isub); plot(td(:,isub),'LineWidth',2,'Color','b'); title(plnames{isub});
end
faxes = findobj(fig,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',9)
    ylabel(faxes(i),'ppb','FontSize',9)
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/',fname0,exp,'.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
part = 'chem_';
exp = '0_04';
spname{1} = '_CO';
spname{2} = '_CH4';
spname{3} = '_CH4AN';
spname{4} = '_C2H6';
spname{5} = '_C2H6AN';
spname{6} = '_C3H8';
spname{7} = '_C3H8AN';
spname{8} = '_NC4H10';
spname{9} = '_NC4H10AN';
spname{10} = '_NC5H12';
spname{11} = '_NC5H12AN';
for i = 1:length(spname)
    fname = [indir,'/',part,exp,spname{i},'.dat'];
    f = importdata(fname,' ',2);
    rd{i} = f.data;
end
M = 2.430605e+19; % air density
% rd{:,11}(1:end-1,:))
td = (horzcat(rd{1},rd{2},rd{3},rd{4},rd{5},rd{6},rd{7},rd{8},rd{9},rd{10},rd{11}))/M*1.0e+9;
dlmwrite(strcat(part,exp,'.dat'),td,'delimiter','\t','precision','%14.6e');
%% Plot mixing ratios
spseqfac = {'O3' 'O1D' 'OH' 'NO' 'NO2' ...
    'HO2' 'H2O2' 'CO' 'CH4' 'HCHO' ...
    'CH3O' 'CH3O2' 'CH3OOH' 'CH3NO3' 'C2H6' ...
    'C2H5O' 'C2H5O2' 'C2H5OOH' 'CH3CHO' 'CH3CO3' ...
    'HCOCH2O2' 'C2H5NO3' 'C3H8' 'IC3H7O' 'IC3H7O2' ...
    'NC3H7O' 'NC3H7O2' 'IC3H7OOH' 'NC3H7OOH' 'C2H5CHO' ...
    'C2H5CO3' 'CH3CO3' 'CH3COCH2O2' 'CH3COCH3' 'IC3H7NO3' ...
    'NC3H7NO3' 'NC4H10' 'NC4H9O' 'SC4H9O' 'NC4H9O2' ...
    'SC4H9O2' 'NC4H9OOH' 'SC4H9OOH' 'C3H7CHO' 'HO1C4O2' ...
    'MEK' 'NC4H9NO3' 'SC4H9NO3' 'NC5H12' 'PEAO' ...
    'PEBO' 'PECO' 'PEAO2' 'PEBO2' 'PECO2' ...
    'PEAOOH' 'PEBOOH' 'PECOOH' 'C4H9CHO' 'MPRK' ...
    'DIEK' 'PEANO3' 'PEBNO3' 'PECNO3'};
spseqpl = {'O3' 'O1D' 'OH' 'NO' 'NO2' ...
    'HO2' 'H2O2' 'CH3O' 'CH3O2' 'HCHO' ...
    'CH4' 'C2H6' 'C3H8' 'NC4H10' 'NC5H12' ...
    'CH3NO3' 'C2H5NO3' 'IC3H7NO3' 'NC3H7NO3' 'NC4H9NO3' ...
    'SC4H9NO3' 'PEANO3' 'PEBNO3' 'PECNO3' 'CO'};
nrows = 5;
ncols = 5;
xend = size(td,1);
fig=figure;
for isub = 1:numel(spseqpl)
    j = find(ismember(spseqfac,spseqpl{isub}));
    subplot(nrows,ncols,isub); plot(td(:,j),'LineWidth',2,'Color','b'); title(spseqpl{isub},'Fontsize',9);
end
faxes = findobj(fig,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',6)
    ylabel(faxes(i),'ppb','FontSize',6)
    set(faxes(i),'FontSize',6)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/',part,exp,'.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
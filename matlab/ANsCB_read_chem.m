% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
M = 2.430605e+19; % air density
indir = '..';
outdir = 'ANsCB_pics';
part = 'chem_';
exp = '1_05';
NOx = '5ppb';
VOC = '4ppb';
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
for isp = 1:length(spname)
    fname = [indir,'/',part,exp,spname{isp},'.dat'];
    f = importdata(fname);
    rd{isp} = f;
end
numden = (horzcat(rd{1},rd{2},rd{3},rd{4},rd{5},rd{6},rd{7},rd{8},rd{9},rd{10},rd{11}));
mixrat = numden/M*1.0e+9;
dlmwrite(strcat(part,exp,'_',NOx,'_',VOC,'.dat'),mixrat,'delimiter','\t','precision','%14.6e');
%% Plot mixing ratios timeseries
spseqfac = {'O3' 'O1D' 'OH' 'NO' 'NO2' ...
    'HO2' 'H2O2' 'CO' 'CH4' 'HCHO' ...
    'CH3O' 'CH3O2' 'CH3OOH' 'CH3NO3' 'C2H6' ...
    'C2H5O' 'C2H5O2' 'C2H5OH' 'C2H5OOH' 'CH3CHO' ...
	'CH3CO3' 'HCOCH2O2' 'C2H5NO3' 'C3H8' 'IC3H7O' ...
    'IC3H7O2' 'NC3H7O' 'NC3H7O2' 'IC3H7OOH' 'NC3H7OOH' ...
    'C2H5CHO' 'C2H5CO3' 'CH3COCH2O2' 'CH3COCH3' 'IC3H7NO3' ...
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
xend = size(mixrat,1);
fig=figure;
for isub = 1:numel(spseqpl)
    j = find(ismember(spseqfac,spseqpl{isub}));
    subplot(nrows,ncols,isub); plot(mixrat(:,j),'LineWidth',2,'Color','b'); 
    title(spseqpl{isub},'Fontsize',9);
end
faxes = findobj(fig,'Type','Axes');
xlimits = [0 xend];
xx =0:(xend)/2:xend;
xxlab = num2str(xx'/4);
for i=1:length(faxes)
    xlabel(faxes(i),'hour','FontSize',6)
    ylabel(faxes(i),'ppb','FontSize',6)
    set(faxes(i),'FontSize',6)
    xlim(faxes(i),xlimits);
    set(faxes(i),'XTick',xx,'XTickLabel',xxlab)
end
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Calculate number of carbon bonds
ncb = [0 0 0 0 0 ...
    0 0 1 4 2 ...
    3 3 3 3 7 ...
    6 6 6 6 5 ...
    4 4 6 10 9 ... 
    9 9 9 9 9 ...
    8 7 7 8 9 ...
    9 13 12 12 12 ...
    12 12 12 10 11 ...
    11 12 12 16 15 ...
    15 15 15 15 15 ...
    15 15 15 14 14 ...
    14 14 14 14];
ncb2D =  repmat(ncb,size(numden,1),1); % vertically stack a row vector
Pbonds = numden.*ncb2D;
RadPotential = sum(Pbonds(end,:),2);
RadPotentialNoCH4 = RadPotential-Pbonds(end,9);
%% Plot number of carbon bonds vs time
Pbonds(Pbonds==0) = NaN; % not right
Pbonds(:,8) = NaN;
Pbonds(:,9) = NaN;
cc=hsv(64);
id = 'MATLAB:legend:IgnoringExtraEntries';
w = warning('off',id);
figure;
hold on;
for ipl=1:length(spseqfac)
    plot(Pbonds(:,ipl),'color',cc(ipl,:),'LineWidth',2);
    legend(spseqfac,'Location','eastoutside','FontSize',5);
end
title(strcat('exp = ',exp,': NOx = ',NOx, ', VOC exc CO,CH4 = ',VOC),'Interpreter','none');
xlimits = [0 xend];
xx =0:(xend)/2:xend;
xxlab = num2str(xx'/4);
xlabel('mins');
ylabel('number of carbon bonds');
xlim(xlimits);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_cb_vs_time.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Plot number of carbon bonds partioning
figure;
bar(Pbonds(end,:));
title(strcat('exp = ',exp,': NOx = ',NOx, ', VOC exc CO,CH4 = ',VOC),'Interpreter','none');
xlabel('mins');
ylabel('number of carbon bonds per compound');
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_cb_partioning.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
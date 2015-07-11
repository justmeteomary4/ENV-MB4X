% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
M = 2.430605e+19; % air density
indir = '..';
outdir = 'ANsCB_pics/test';
part = 'chem_';
exp = '1_05';
NOx = '1000ppt';
VOC = 'all';
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
    'HO2' 'H2O2' 'CO' 'HNO3' 'CH4' 'HCHO' ...
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
spseqpl = {'O3' 'O1D' 'OH' 'NO' 'NO2' 'HO2' 'CO' ...
    'CH4' 'C2H6' 'C3H8' 'NC4H10' 'H2O2' 'NC5H12' 'H2O2'...
    'CH3O2' 'C2H5O2' 'IC3H7O2' 'NC4H9O2' 'H2O2' 'PEAO2' 'H2O2'...
    'CH3NO3' 'C2H5NO3' 'IC3H7NO3' 'NC4H9NO3' 'H2O2' 'PEANO3' 'H2O2'};
xend = size(mixrat,1);
C3H7O2 = mixrat(:,27)+mixrat(:,29);
NC4H9O2 = mixrat(:,41)+mixrat(:,42);
IC4H9O2 = mixrat(:,1);  %!
NC5H11O2 = mixrat(:,54)+mixrat(:,55)+mixrat(:,56);
IC5H11O2 = mixrat(:,1); %!
C3H7NO3 = mixrat(:,36)+mixrat(:,37);
NC4H9NO3 = mixrat(:,48)+mixrat(:,49);
IC4H9NO3 = mixrat(:,1); %!
NC5H11NO3 = mixrat(:,63)+mixrat(:,64)+mixrat(:,65);
IC5H11NO3 = mixrat(:,1); %!

figure; plot(mixrat(:,1),'LineWidth',2,'Color','b'); title('O_3','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','O3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,2),'LineWidth',2,'Color','b'); title('O(^1D)','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','O1D.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,3),'LineWidth',2,'Color','b'); title('OH','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','OH.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,4),'LineWidth',2,'Color','b'); title('NO','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','NO.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,5),'LineWidth',2,'Color','b'); title('NO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','NO2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,6),'LineWidth',2,'Color','b'); title('HO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','HO2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,8),'LineWidth',2,'Color','b'); title('CO','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','CO.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

 
figure; plot(mixrat(:,10),'LineWidth',2,'Color','b'); title('CH_4','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','CH4.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,16),'LineWidth',2,'Color','b'); title('C_2H_6','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','C2H6.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,25),'LineWidth',2,'Color','b'); title('C_3H_8','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','C3H8.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,38),'LineWidth',2,'Color','b'); title('n-C_4H_1_0','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','nC4H10.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,1),'LineWidth',2,'Color','r'); title('i-C_4H_1_0','Fontsize',10);     %!
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','iC4H10.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,50),'LineWidth',2,'Color','r'); title('n-C_5H_1_2','Fontsize',10);   %!
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','nC5H12.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,1),'LineWidth',2,'Color','r'); title('i-C_5H_1_2','Fontsize',10);   %!
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','iC5H12.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

    
figure; plot(mixrat(:,13),'LineWidth',2,'Color','b'); title('CH_3O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','CH302.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,18),'LineWidth',2,'Color','b'); title('C_2H_5O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','C2H5O2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(C3H7O2,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','C3H7O2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(NC4H9O2,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','nC4H9O2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(IC4H9O2,'LineWidth',2,'Color','r'); title('\Sigma i-C_4H_9O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','IC4H9O2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(NC5H11O2,'LineWidth',2,'Color','r'); title('\Sigma n-C_5H_1_1O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','nC5H11O2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(IC5H11O2,'LineWidth',2,'Color','r'); title('\Sigma i-C_5H_1_1O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','iC5H11O2.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

    
figure; plot(mixrat(:,15),'LineWidth',2,'Color','b'); title('CH_3ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','CH3NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(mixrat(:,24),'LineWidth',2,'Color','b'); title('C_2H_5ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','C2H5NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(C3H7NO3,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','C3H7NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(NC4H9NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','nC4H9NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(IC4H9NO3,'LineWidth',2,'Color','r'); title('\Sigma i-C_4H_9ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','iC4H9NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(NC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','nC5H11NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

figure; plot(IC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_','iC5H11NO3.pdf'); print(gcf,'-dpdf',imgname);
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')

% xlabel('hour','FontSize',6)
% ylabel('ppb','FontSize',6)
% addpath('D:\FACSIMILE\ANsCBmodel\altmany-export_fig-ea12243');
% set(gcf,'visible','off','PaperOrientation','landscape','PaperType','a4')
% export_fig lalala.pdf
% print(gcf,'-dpdf',imgname); %,'PaperType','a4'
%% Calculate number of carbon bonds
ncb = [0 0 0 0 0 ...
    0 0 1 0 4 2 ...
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
RadPotentialNoCH4 = RadPotential-Pbonds(end,10);
%% Plot number of carbon bonds vs time
Pbonds(Pbonds==0) = NaN; % not right
Pbonds(:,8) = NaN; % CO
Pbonds(:,10) = NaN; % CH4
cc=hsv(length(ncb));
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
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_cb_vs_time_noHNO3.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Plot number of carbon bonds partioning
figure;
bar(Pbonds(end,:));
title(strcat('exp = ',exp,': NOx = ',NOx, ', VOC exc CO,CH4 = ',VOC),'Interpreter','none');
xlabel('mins');
ylabel('number of carbon bonds per compound');
imgname = strcat(outdir,'/',part,exp,'_',NOx,'_',VOC,'_cb_partioning_noHNO3.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
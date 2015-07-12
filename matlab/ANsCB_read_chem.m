% Read and plot resulting mixing ratios from ANsCB model
%% Read number densities and convert them to mixing ratios
clear; clc;
M = 2.430605e+19; % air density
indir = '..';
outdir = 'ANsCB_pics/test2';
part = 'chem';
ANs = [0 1 2 3 4 5 6 7];
NOx = [5 25 50 100 250 500 750 1000 2500 5000 10000];
comp{1} = 'CO';
comp{2} = 'CH4';
comp{3} = 'CH4AN';
comp{4} = 'C2H6';
comp{5} = 'C2H6AN';
comp{6} = 'C3H8';
comp{7} = 'C3H8AN';
comp{8} = 'nC4H10';
comp{9} = 'nC4H10AN';
comp{10} = 'iC4H10';
comp{11} = 'iC4H10AN';
comp{12} = 'nC5H12';
comp{13} = 'nC5H12AN';
comp{14} = 'iC5H12';
comp{15} = 'iC5H12AN';
for iexp = 1:length(ANs)
    for iNOx = 1:length(NOx)
        aggr_array = [];
        for icomp = 1:length(comp)
            fname = [indir,'/',part,'_',num2str(ANs(iexp)),'_',num2str(NOx(iNOx)),'_',comp{icomp},'.dat'];
            f = importdata(fname);
            aggr_array = horzcat(aggr_array, f);
        end
        d{iexp,iNOx} = aggr_array;
    end
end
%%
numden = (horzcat(d{1},d{2},d{3},d{4},d{5},d{6},d{7},d{8},d{9},d{10},d{11}));
mixrat = numden/M*1.0e+9;
%% Plot mixing ratios timeseries
spseqfac = {'O3' 'O1D' 'OH' 'NO' 'NO2' ...
    'HO2' 'H2O2' 'CO' 'HNO3' 'CH4' ...
	'HCHO' 'CH3O' 'CH3O2' 'CH3OOH' 'CH3NO3' ...
	'C2H6' 'C2H5O' 'C2H5O2' 'C2H5OH' 'C2H5OOH' ...
	'CH3CHO' 'CH3CO3' 'HCOCH2O2' 'C2H5NO3' 'C3H8' ...
	'IC3H7O' 'IC3H7O2' 'NC3H7O' 'NC3H7O2' 'IC3H7OOH' ...
	'NC3H7OOH' 'C2H5CHO' 'C2H5CO3' 'CH3COCH2O2' 'CH3COCH3' ...
	'IC3H7NO3' 'NC3H7NO3' 'NC4H10' 'NC4H9O' 'SC4H9O' ...
	'NC4H9O2' 'SC4H9O2' 'NC4H9OOH' 'SC4H9OOH' 'C3H7CHO' ...
	'HO1C4O2' 'MEK' 'NC4H9NO3' 'SC4H9NO3' 'IC4H10' ...
	'IC4H9O' 'TC4H9O' 'IC4H9O2' 'TC4H9O2' 'IC4H9OOH' ...
	'TC4H9OOH' 'IPRCHO' 'IC4H9NO3' 'TC4H9NO3' 'NC5H12' ...
	'PEAO' 'PEBO' 'PECO' 'PEAO2' 'PEBO2' ...
	'PECO2' 'PEAOOH' 'PEBOOH' 'PECOOH' 'C4H9CHO' ...
	'MPRK' 'DIEK' 'PEANO3' 'PEBNO3' 'PECNO3' ...
	'IC5H12' 'IPEAO' 'IPEBO' 'IPECO' 'IPEAO2' ...
	'IPEBO2' 'IPECO2' 'IPEAOOH' 'IPEBOOH' 'IPECOOH' ...
	'BUT2CHO' 'MIPK' 'IPEANO3' 'IPEBNO3' 'IPECNO3'};
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
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','O3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,2),'LineWidth',2,'Color','b'); title('O(^1D)','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','O1D.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,3),'LineWidth',2,'Color','b'); title('OH','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','OH.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,4),'LineWidth',2,'Color','b'); title('NO','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','NO.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,5),'LineWidth',2,'Color','b'); title('NO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','NO2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,6),'LineWidth',2,'Color','b'); title('HO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','HO2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,8),'LineWidth',2,'Color','b'); title('CO','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','CO.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

 
figure; plot(mixrat(:,10),'LineWidth',2,'Color','b'); title('CH_4','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','CH4.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,16),'LineWidth',2,'Color','b'); title('C_2H_6','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','C2H6.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,25),'LineWidth',2,'Color','b'); title('C_3H_8','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','C3H8.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,38),'LineWidth',2,'Color','b'); title('n-C_4H_1_0','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','nC4H10.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,1),'LineWidth',2,'Color','r'); title('i-C_4H_1_0','Fontsize',10);     %!
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','iC4H10.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,50),'LineWidth',2,'Color','r'); title('n-C_5H_1_2','Fontsize',10);   %!
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','nC5H12.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,1),'LineWidth',2,'Color','r'); title('i-C_5H_1_2','Fontsize',10);   %!
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','iC5H12.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

    
figure; plot(mixrat(:,13),'LineWidth',2,'Color','b'); title('CH_3O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','CH302.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,18),'LineWidth',2,'Color','b'); title('C_2H_5O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','C2H5O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(C3H7O2,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','C3H7O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(NC4H9O2,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','nC4H9O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(IC4H9O2,'LineWidth',2,'Color','r'); title('\Sigma i-C_4H_9O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','IC4H9O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(NC5H11O2,'LineWidth',2,'Color','r'); title('\Sigma n-C_5H_1_1O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','nC5H11O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(IC5H11O2,'LineWidth',2,'Color','r'); title('\Sigma i-C_5H_1_1O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','iC5H11O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

    
figure; plot(mixrat(:,15),'LineWidth',2,'Color','b'); title('CH_3ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','CH3NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(mixrat(:,24),'LineWidth',2,'Color','b'); title('C_2H_5ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','C2H5NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(C3H7NO3,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','C3H7NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(NC4H9NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','nC4H9NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(IC4H9NO3,'LineWidth',2,'Color','r'); title('\Sigma i-C_4H_9ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','iC4H9NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(NC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','nC5H11NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

figure; plot(IC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_','iC5H11NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off')
print(gcf,'-dpdf',imgname);

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
title(strcat('exp = ',ANs,': NOx = ',NOx, ', VOC exc CO,CH4 = ',VOC),'Interpreter','none');
xlimits = [0 xend];
xx =0:(xend)/2:xend;
xxlab = num2str(xx'/4);
xlabel('mins');
ylabel('number of carbon bonds');
xlim(xlimits);
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_',VOC,'_cb_vs_time_noHNO3.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Plot number of carbon bonds partioning
figure;
bar(Pbonds(end,:));
title(strcat('exp = ',ANs,': NOx = ',NOx, ', VOC exc CO,CH4 = ',VOC),'Interpreter','none');
xlabel('mins');
ylabel('number of carbon bonds per compound');
imgname = strcat(outdir,'/',part,ANs,'_',NOx,'_',VOC,'_cb_partioning_noHNO3.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
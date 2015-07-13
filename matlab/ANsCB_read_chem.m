% Read and plot resulting mixing ratios from ANsCB model
%% Read number densities and convert them to mixing ratios
clear; clc;
M = 2.430605e+19; % air density
indir = '..';
common_outdir = 'ANsCB_pics';
addpath('D:\FACSIMILE\ANsCBmodel\altmany-export_fig-ea12243');
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
for iANs = 1:length(ANs)
    for iNOx = 1:length(NOx)
        aggr_array = [];
        for icomp = 1:length(comp)
            fname = [indir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_',comp{icomp},'.dat'];
            f = importdata(fname);
            aggr_array = horzcat(aggr_array, f);
        end
        numden{iANs,iNOx} = aggr_array;               % number density
        mixrat{iANs,iNOx} = aggr_array./M*1.0e+9; % mixing ratio
    end
end
xend = 96;
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
% Set the index of experiment
iANs = 1;
for iNOx = 1:length(NOx)
    C3H7O2 = mixrat{iANs,iNOx}(:,27)+mixrat{iANs,iNOx}(:,29);
    nC4H9O2 = mixrat{iANs,iNOx}(:,41)+mixrat{iANs,iNOx}(:,42);
    iC4H9O2 = mixrat{iANs,iNOx}(:,53)+mixrat{iANs,iNOx}(:,54);
    nC5H11O2 = mixrat{iANs,iNOx}(:,64)+mixrat{iANs,iNOx}(:,65)+mixrat{iANs,iNOx}(:,66);
    iC5H11O2 = mixrat{iANs,iNOx}(:,80)+mixrat{iANs,iNOx}(:,81)+mixrat{iANs,iNOx}(:,82);
    C3H7NO3 = mixrat{iANs,iNOx}(:,36)+mixrat{iANs,iNOx}(:,37);
    nC4H9NO3 = mixrat{iANs,iNOx}(:,48)+mixrat{iANs,iNOx}(:,49);
    iC4H9NO3 = mixrat{iANs,iNOx}(:,58)+mixrat{iANs,iNOx}(:,59);
    nC5H11NO3 = mixrat{iANs,iNOx}(:,73)+mixrat{iANs,iNOx}(:,74)+mixrat{iANs,iNOx}(:,75);
    iC5H11NO3 = mixrat{iANs,iNOx}(:,88)+mixrat{iANs,iNOx}(:,89)+mixrat{iANs,iNOx}(:,90);
    
outdir = strcat(common_outdir,'/',num2str(iANs),'_',num2str(NOx(iNOx)),'ppt');
if exist(outdir) ~= 7; mkdir(outdir); end
    
figure; plot(mixrat{iANs,iNOx}(:,1),'LineWidth',2,'Color','b'); title('O_3','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','O3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color', 'w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,2),'LineWidth',2,'Color','b'); title('O(^1D)','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','O1D.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,3),'LineWidth',2,'Color','b'); title('OH','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','OH.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,4),'LineWidth',2,'Color','b'); title('NO','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','NO.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,5),'LineWidth',2,'Color','b'); title('NO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','NO2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,6),'LineWidth',2,'Color','b'); title('HO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','HO2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,8),'LineWidth',2,'Color','b'); title('CO','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','CO.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,10),'LineWidth',2,'Color','b'); title('CH_4','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','CH4.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,16),'LineWidth',2,'Color','b'); title('C_2H_6','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','C2H6.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,25),'LineWidth',2,'Color','b'); title('C_3H_8','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','C3H8.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,38),'LineWidth',2,'Color','b'); title('n-C_4H_1_0','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','nC4H10.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,50),'LineWidth',2,'Color','b'); title('i-C_4H_1_0','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','iC4H10.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,60),'LineWidth',2,'Color','b'); title('n-C_5H_1_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','nC5H12.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,76),'LineWidth',2,'Color','b'); title('i-C_5H_1_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','iC5H12.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,13),'LineWidth',2,'Color','b'); title('CH_3O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','CH302.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,18),'LineWidth',2,'Color','b'); title('C_2H_5O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','C2H5O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(C3H7O2,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','C3H7O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(nC4H9O2,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','nC4H9O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(iC4H9O2,'LineWidth',2,'Color','b'); title('\Sigma i-C_4H_9O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','iC4H9O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(nC5H11O2,'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','nC5H11O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(iC5H11O2,'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1O_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','iC5H11O2.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);
    
figure; plot(mixrat{iANs,iNOx}(:,15),'LineWidth',2,'Color','b'); title('CH_3ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','CH3NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(mixrat{iANs,iNOx}(:,24),'LineWidth',2,'Color','b'); title('C_2H_5ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','C2H5NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(C3H7NO3,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','C3H7NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(nC4H9NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','nC4H9NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(iC4H9NO3,'LineWidth',2,'Color','b'); title('\Sigma i-C_4H_9ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','iC4H9NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(nC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','nC5H11NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

figure; plot(iC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1ONO_2','Fontsize',10);
imgname = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_','iC5H11NO3.pdf'); 
xlimits = [0 xend]; xx =0:(xend)/2:xend; xxlab = num2str(xx'/4); xlim(gca,xlimits);
set(gca,'XTick',xx,'XTickLabel',xxlab); set(gca,'FontSize',6); set(gcf,'visible','off','Color','w')
export_fig(imgname);

end
%% Plot all in one figure
outdir = common_outdir;
nrows = 4;
ncols = 7;
fig=figure;
for iNOx = 1:length(NOx)
    subplot(nrows,ncols,1);  plot(mixrat{iANs,iNOx}(:,1),'LineWidth',2,'Color','b'); title('O_3','Fontsize',7);
	subplot(nrows,ncols,2);  plot(mixrat{iANs,iNOx}(:,2),'LineWidth',2,'Color','b'); title('O(^1D)','Fontsize',7);
	subplot(nrows,ncols,3);  plot(mixrat{iANs,iNOx}(:,3),'LineWidth',2,'Color','b'); title('OH','Fontsize',7);
	subplot(nrows,ncols,4);  plot(mixrat{iANs,iNOx}(:,4),'LineWidth',2,'Color','b'); title('NO','Fontsize',7);
	subplot(nrows,ncols,5);  plot(mixrat{iANs,iNOx}(:,5),'LineWidth',2,'Color','b'); title('NO_2','Fontsize',7);
	subplot(nrows,ncols,6);  plot(mixrat{iANs,iNOx}(:,6),'LineWidth',2,'Color','b'); title('HO_2','Fontsize',7);
	subplot(nrows,ncols,7);  plot(mixrat{iANs,iNOx}(:,8),'LineWidth',2,'Color','b'); title('CO','Fontsize',7);
	subplot(nrows,ncols,8);  plot(mixrat{iANs,iNOx}(:,10),'LineWidth',2,'Color','b'); title('CH_4','Fontsize',7);
	subplot(nrows,ncols,9);  plot(mixrat{iANs,iNOx}(:,16),'LineWidth',2,'Color','b'); title('C_2H_6','Fontsize',7);
	subplot(nrows,ncols,10); plot(mixrat{iANs,iNOx}(:,25),'LineWidth',2,'Color','b'); title('C_3H_8','Fontsize',7);
	subplot(nrows,ncols,11); plot(mixrat{iANs,iNOx}(:,38),'LineWidth',2,'Color','b'); title('n-C_4H_1_0','Fontsize',7);
	subplot(nrows,ncols,12); plot(mixrat{iANs,iNOx}(:,50),'LineWidth',2,'Color','b'); title('i-C_4H_1_0','Fontsize',7);
	subplot(nrows,ncols,13); plot(mixrat{iANs,iNOx}(:,60),'LineWidth',2,'Color','b'); title('n-C_5H_1_2','Fontsize',7);
	subplot(nrows,ncols,14); plot(mixrat{iANs,iNOx}(:,76),'LineWidth',2,'Color','b'); title('i-C_5H_1_2','Fontsize',7);
	subplot(nrows,ncols,15); plot(mixrat{iANs,iNOx}(:,13),'LineWidth',2,'Color','b'); title('CH_3O_2','Fontsize',7);
	subplot(nrows,ncols,16); plot(mixrat{iANs,iNOx}(:,18),'LineWidth',2,'Color','b'); title('C_2H_5O_2','Fontsize',7);
	subplot(nrows,ncols,17); plot(C3H7O2,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7O_2','Fontsize',7);
	subplot(nrows,ncols,18); plot(nC4H9O2,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9O_2','Fontsize',7);
	subplot(nrows,ncols,19); plot(iC4H9O2,'LineWidth',2,'Color','b'); title('\Sigma i-C_4H_9O_2','Fontsize',7);
	subplot(nrows,ncols,20); plot(nC5H11O2,'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1O_2','Fontsize',7);
	subplot(nrows,ncols,21); plot(iC5H11O2,'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1O_2','Fontsize',7);
	subplot(nrows,ncols,22); plot(mixrat{iANs,iNOx}(:,15),'LineWidth',2,'Color','b'); title('CH_3ONO_2','Fontsize',7);
	subplot(nrows,ncols,23); plot(mixrat{iANs,iNOx}(:,24),'LineWidth',2,'Color','b'); title('C_2H_5ONO_2','Fontsize',7);
	subplot(nrows,ncols,24); plot(C3H7NO3,'LineWidth',2,'Color','b'); title('\Sigma C_3H_7ONO_2','Fontsize',7);
	subplot(nrows,ncols,25); plot(nC4H9NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9ONO_2','Fontsize',7);
	subplot(nrows,ncols,26); plot(iC4H9NO3,'LineWidth',2,'Color','b'); title('\Sigma i-C_4H_9ONO_2','Fontsize',7);
	subplot(nrows,ncols,27); plot(nC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1ONO_2','Fontsize',7);
	subplot(nrows,ncols,28); plot(iC5H11NO3,'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1ONO_2','Fontsize',7);
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
imgname28 = strcat(outdir,'/',part,'_',num2str(ANs(iANs)),'_',num2str(NOx(iNOx)),'_28.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname28);
end
%% Net O3 loss/production vs NOx
clc
outdir = common_outdir;
fig1 = figure; %set(gcf,'visible','off')
% fig2 = figure; %set(fig2,'visible','off');
% fig3 = figure;
cvec =[0.25 0.25 0.25
          0.25 0.25 0.75 
          0.25 0.75 1.00 
          1.00 0.50 0.00
          0.25 0.75 0.25
          1.00 0.00 0.25
          0.75 0.25 0.25
          1.00 0.75 0.25
          0.25 1.00 0.00
          0.50 0.25 0.75
          0.50 0.75 0.75
          0.75 0.25 0.25
          0.25 1.00 0.25];

for iANs = 1:length(ANs)
    for iNOx = 1:length(NOx)
        O3rate(iANs,iNOx,:) =  gradient(mixrat{iANs,iNOx}(:,1))./15.*60;
        NOxabun(iANs,iNOx,:) =  (mixrat{iANs,iNOx}(:,38)+mixrat{iANs,iNOx}(:,50));
%         figure(fig2)
%         scatter(NOxabun(iANs,iNOx,:),O3rate(iANs,iNOx,:),2^6,cvec(iANs,:));
%         hold on;
%             figure(fig3)
%             plot(mixrat{iANs,1}(:,1)); title(strcat('NOx = ',num2str(NOx(1))));
%             hold on;
    end
end
% Net O3 production in base experiment as a =f(NOx)
for iNOx = 1:length(NOx)
    O3netbase(iNOx) = mixrat{1,iNOx}(end,1)-mixrat{1,iNOx}(1,1); % final mixrat - initial mixrat
end

for iANs = 2:length(ANs)
    for iNOx = 1:length(NOx)
        O3net_other(iNOx) = mixrat{iANs,iNOx}(end,1)-mixrat{iANs,iNOx}(1,1);
    end
    O3netdiff(iANs,:) = O3netbase - O3net_other;
    figure(fig1)
    plot(NOx,O3netdiff(iANs,:),'Color',cvec(iANs,:),'LineWidth',2);
    hold on;
 end
% figure; contourf(mean(O3rate(:,:,:),3)); colorbar
imgnameO3NOxdiff = strcat(outdir,'/',part,'_O3NOxdiff.png');
figure(fig1)
title('Differences in net O_3 production/loss depending on RONO_2 chemistry');
legend('base - CH_3ONO_2','base - C_2H_5ONO_2','base - \Sigma C_3H_7ONO_2',...
'base - \Sigma n-C_4H_9ONO_2','base - \Sigma i-C_4H_9ONO_2','base - \Sigma n-C_5H_1_2ONO_2',...
'base - \Sigma i-C_5H_1_2ONO_2','Location','east');
xlabel('NOx, ppt');
ylabel('Net O_3 change, ppb');
print(gcf,'-dpng','-r300',imgnameO3NOxdiff);
%% Calculate number of carbon bonds
ncb = [0 0 0 0 0 ...
    0 0 1 0 4 ...
	2 3 3 3 3 ...
	7 6 6 6 6 ...
	5 4 4 6 10 ...
	9 9 9 9 9 ...
	9 8 7 7 8 ...
	9 9 13 12 12 ...
	12 12 12 12 10 ...
	11 11 12 12 13 ...
	12 12 12 12 12 ...
	12 12 12 12 16 ...
	15 15 15 15 15 ...
	15 15 15 15 14 ...
	14 14 15 15 15 ...
	16 15 15 15 15 ...
	15 15 15 15 15 ...
	14 14 15 15 15];

for i = 1:numel(ANs)
    for j = 1:numel(NOx)
        arr = numden{i,j};
        ncb2D =  repmat(ncb,size(arr,1),1); % vertically stack a row vector
        Pbonds(i,j,:,:) = arr.*ncb2D;
        RadPotentialInit(i,j) = sum(Pbonds(i,j,1,:),4);
        RadPotentialEnd(i,j) = sum(Pbonds(i,j,end,:),4);
        RadPotentialDiff(i,j) = RadPotentialEnd(i,j) - RadPotentialInit(i,j);
        epsilon(i,j) = (mixrat{i,j}(end,1)-mixrat{i,j}(1,1))/RadPotentialDiff(i,j);
        RadPotentialRate(i,j,:) = gradient(squeeze(sum(Pbonds(i,j,:,:),4)))./15.*60;
        O3perCBrate(i,j,:) = O3rate(i,j,:)./RadPotentialRate(i,j,:);
%         RadPotentialNoCH4(i,j) = RadPotentialEnd(i,j) - Pbonds(i,j,end,10);
    end
end
%%

 for j = 1:numel(NOx)
     j
     figure
     for i = 1:numel(ANs)
         plot(squeeze(O3perCBrate(i,j,:)),'Color',cvec(i,:),'LineWidth',2);
         hold on;
         set(gcf,'visible','off')
     end
     lalala = strcat(outdir,'/',part,'_lalala_',num2str(NOx(j)),'.png');
     legend('base - CH_3ONO_2','base - C_2H_5ONO_2','base - \Sigma C_3H_7ONO_2',...
'base - \Sigma n-C_4H_9ONO_2','base - \Sigma i-C_4H_9ONO_2','base - \Sigma n-C_5H_1_2ONO_2',...
'base - \Sigma i-C_5H_1_2ONO_2','Location','east');
     print(gcf,'-dpng','-r300',lalala);
 end
% contourf(epsilon); colorbar

figure;plot(squeeze(O3rate(1,1,:)))
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
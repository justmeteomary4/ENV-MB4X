% Read and plot resulting mixing ratios from ANsCB model
%% Read number densities and convert them to mixing ratios
clear; clc;
M = 2.430605e+19; % air density
indir = '..';
common_outdir = 'ANsCB_pics';
addpath('D:\FACSIMILE\ANsCBmodel\altmany-export_fig-ea12243');
addpath('D:\FACSIMILE\ANsCBmodel\paruly\paruly');
part = 'chem';
AN = {'noAN' 'allAN'};
NOx = [5 25 50 100 250 500 750 1000 2500 5000 10000];
VOC = [1 2 3 4 5 6 7 8 9 10 11];
comp = {'CO' 'CH4' 'CH4AN' 'C2H6' 'C2H6AN' 'C3H8' 'C3H8AN' 'nC4H10' 'nC4H10AN' ...
    'iC4H10' 'iC4H10AN' 'nC5H12' 'nC5H12AN' 'iC5H12' 'iC5H12AN'};
for i = 1:numel(AN) % calc numden and mixrat
    for j = 1:numel(NOx)
        for k = 1:numel(VOC)
            aggr_array = [];
            for icomp = 1:numel(comp)
                fname = [indir,'/',part,'_',num2str(AN{i}),'_',num2str(NOx(j)),'_',num2str(VOC(k)),'_',comp{icomp},'.dat'];
                f = importdata(fname);
                aggr_array = horzcat(aggr_array, f);
            end
            numden(i,j,k,:,:) = aggr_array;               % number density
            mixrat(i,j,k,:,:) = aggr_array./M*1.0e+9; % mixing ratio
        end
    end
end
tN = 96;
%% General plotting variables
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
VOCsum = [1781.52 1809.92 1838.32 1866.71 1895.11 1923.51 1951.91 1980.31 2008.70 2037.10 2065.50];
onoff = {'OFF' 'ON'};
%% Plot all in one figure
clc;
nrows = 3;
ncols = 7;
fig=figure;
for i = 1:numel(AN) % print all in one .png
    for j = 1:numel(NOx)
        for k = 1:numel(VOC) 
            outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i},'_',num2str(VOC(k)));
            if exist(outdir,'dir') ~= 7; mkdir(outdir); end

C3H7O2 = mixrat(i,j,k,:,27)+mixrat(i,j,k,:,29);
nC4H9O2 = mixrat(i,j,k,:,41)+mixrat(i,j,k,:,42);
iC4H9O2 = mixrat(i,j,k,:,53)+mixrat(i,j,k,:,54);
nC5H11O2 = mixrat(i,j,k,:,64)+mixrat(i,j,k,:,65)+mixrat(i,j,k,:,66);
iC5H11O2 = mixrat(i,j,k,:,80)+mixrat(i,j,k,:,81)+mixrat(i,j,k,:,82);
C3H7NO3 = mixrat(i,j,k,:,36)+mixrat(i,j,k,:,37);
nC4H9NO3 = mixrat(i,j,k,:,48)+mixrat(i,j,k,:,49);
iC4H9NO3 = mixrat(i,j,k,:,58)+mixrat(i,j,k,:,59);
nC5H11NO3 = mixrat(i,j,k,:,73)+mixrat(i,j,k,:,74)+mixrat(i,j,k,:,75);
iC5H11NO3 = mixrat(i,j,k,:,88)+mixrat(i,j,k,:,89)+mixrat(i,j,k,:,90);

subplot(nrows,ncols,1);  plot(squeeze(mixrat(i,j,k,:,1)),'LineWidth',2,'Color','b'); title('O_3','Fontsize',7);
subplot(nrows,ncols,2);  plot(squeeze(mixrat(i,j,k,:,2)),'LineWidth',2,'Color','b'); title('O(^1D)','Fontsize',7);
subplot(nrows,ncols,3);  plot(squeeze(mixrat(i,j,k,:,3)),'LineWidth',2,'Color','b'); title('OH','Fontsize',7);
subplot(nrows,ncols,4);  plot(squeeze(mixrat(i,j,k,:,4)),'LineWidth',2,'Color','b'); title('NO','Fontsize',7);
subplot(nrows,ncols,5);  plot(squeeze(mixrat(i,j,k,:,5)),'LineWidth',2,'Color','b'); title('NO_2','Fontsize',7);
subplot(nrows,ncols,6);  plot(squeeze(mixrat(i,j,k,:,6)),'LineWidth',2,'Color','b'); title('HO_2','Fontsize',7);
subplot(nrows,ncols,7);  plot(squeeze(mixrat(i,j,k,:,8)),'LineWidth',2,'Color','b'); title('CO','Fontsize',7);
subplot(nrows,ncols,8);  plot(squeeze(mixrat(i,j,k,:,13)),'LineWidth',2,'Color','b'); title('CH_3O_2','Fontsize',7);
subplot(nrows,ncols,9);  plot(squeeze(mixrat(i,j,k,:,18)),'LineWidth',2,'Color','b'); title('C_2H_5O_2','Fontsize',7);
subplot(nrows,ncols,10); plot(squeeze(C3H7O2),'LineWidth',2,'Color','b'); title('\Sigma C_3H_7O_2','Fontsize',7);
subplot(nrows,ncols,11); plot(squeeze(nC4H9O2),'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9O_2','Fontsize',7);
subplot(nrows,ncols,12); plot(squeeze(iC4H9O2),'LineWidth',2,'Color','b'); title('\Sigma i-C_4H_9O_2','Fontsize',7);
subplot(nrows,ncols,13); plot(squeeze(nC5H11O2),'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1O_2','Fontsize',7);
subplot(nrows,ncols,14); plot(squeeze(iC5H11O2),'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1O_2','Fontsize',7);
subplot(nrows,ncols,15); plot(squeeze(mixrat(i,j,k,:,15)),'LineWidth',2,'Color','b'); title('CH_3ONO_2','Fontsize',7);
subplot(nrows,ncols,16); plot(squeeze(mixrat(i,j,k,:,24)),'LineWidth',2,'Color','b'); title('C_2H_5ONO_2','Fontsize',7);
subplot(nrows,ncols,17); plot(squeeze(C3H7NO3),'LineWidth',2,'Color','b'); title('\Sigma C_3H_7ONO_2','Fontsize',7);
subplot(nrows,ncols,18); plot(squeeze(nC4H9NO3),'LineWidth',2,'Color','b'); title('\Sigma n-C_4H_9ONO_2','Fontsize',7);
subplot(nrows,ncols,19); plot(squeeze(iC4H9NO3),'LineWidth',2,'Color','b'); title('\Sigma i-C_4H_9ONO_2','Fontsize',7);
subplot(nrows,ncols,20); plot(squeeze(nC5H11NO3),'LineWidth',2,'Color','b'); title('\Sigma n-C_5H_1_1ONO_2','Fontsize',7);
subplot(nrows,ncols,21); plot(squeeze(iC5H11NO3),'LineWidth',2,'Color','b'); title('\Sigma i-C_5H_1_1ONO_2','Fontsize',7);

ha = axes('Position',[0.5 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized','clipping','off');
titlemain(j) = text(0,1,strcat('\bf NOx= ',num2str(NOx(j)),'ppt'),'HorizontalAlignment','center','VerticalAlignment','top');

 faxes = findobj(fig,'Type','Axes');
 xlimits = [0 tN];
 xx =0:(tN)/2:tN;
 xxlab = num2str(xx'/4);
 for iaxis=1:length(faxes)
     xlabel(faxes(iaxis),'hour','FontSize',6)
     ylabel(faxes(iaxis),'ppb','FontSize',6)
     set(faxes(iaxis),'FontSize',6)
     xlim(faxes(iaxis),xlimits);
     set(faxes(iaxis),'XTick',xx,'XTickLabel',xxlab)
 end
imgname21 = strcat(outdir,'/',part,'_',AN{i},'_',num2str(NOx(j)),'_',num2str(VOC(k)),'_21pics.png');
set(gcf,'visible','off')
% print(gcf,'-dpng','-r300',imgname21);
        end
    end
end
%% Net O3 production vs NOx and VOC depending on ANs presence (with/without)
clc;
for i = 1:numel(AN) % contourf net O3 production vs NOx and VOC
    outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
    if exist(outdir,'dir') ~= 7; mkdir(outdir); end
    for j = 1:numel(NOx)
        for k = 1:numel(VOC) 
            netO3(i,j,k) = (mixrat(i,j,k,end,1)-mixrat(i,j,k,1,1))/24; % /24 rate, changeable
            netOH(i,j,k) = mixrat(i,j,k,end,3)-mixrat(i,j,k,1,3);
            netHO2(i,j,k) = mixrat(i,j,k,end,6)-mixrat(i,j,k,1,6);
        end
    end
    figure
    contourf(NOx,VOCsum,squeeze(netO3(i,:,:))'); colorbar; colormap(paruly) % transposed
    imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3_rate.png');
    title(['Net O_3 production with RONO_2 chemistry ',onoff{i}]);
    xlabel('NOx, ppt');
    ylabel('VOC, ppb');
    set(gca,'XScale','log');
    set(gca, 'CLim', [min(min(min(netO3))), max(max(max(netO3)))]);
    set(gcf,'visible','off')
    print(gcf,'-dpng','-r300',imgname);
end
%% Difference in net O3 production vs NOx and VOC between experiments with and without ANs
clc;
i = 2;
outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
if exist(outdir,'dir') ~= 7; mkdir(outdir); end
for j = 1:numel(NOx) % difference in net O3 production
    for k = 1:numel(VOC)
        netdiffO3(j,k) = netO3(2,j,k)-netO3(1,j,k);
    end
end
figure
contourf(NOx,VOCsum,netdiffO3'); colorbar; colormap(paruly) % transposed
imgname = strcat(outdir,'/',part,'_',AN{i},'_netdiffO3.png');
title('Difference in net O_3 production');
xlabel('NOx, ppt');
ylabel('VOC, ppb');
set(gca,'XScale','log');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Net O3 production vs NOx (Z = VOC)
clc;
cmap = cvec;
for i = 1:numel(AN) % net O3 production vs NOx
    outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
    figure
    if exist(outdir,'dir') ~= 7; mkdir(outdir); end
        for k = 1:numel(VOC)
            plot(NOx,netO3(i,:,k),'Color',cmap(k,:),'LineWidth',2); hold on;
        end
        imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3_vs_NOx.png');
        title('Net O_3 production');
        leg = legend('1781.52','1809.92','1838.32','1866.71','1895.11','1923.51','1951.91','1980.31',...
    '2008.70','2037.10','2065.50','Location','eastoutside');
        legv = get(leg,'title');
        set(legv,'string','\Sigma VOCs');
        xlabel('NOx, ppt');
        ylabel('O_3, ppb');
        set(gca,'XScale','log');
        set(gcf,'visible','off')
        print(gcf,'-dpng','-r300',imgname);
end
%% Net O3 production vs VOCsum (Z = NOx)
clc;
cmap = cvec;
for i = 1:numel(AN) % net O3 production vs VOCsum
    outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
    figure
    if exist(outdir,'dir') ~= 7; mkdir(outdir); end
        for j = 1:numel(NOx)
            plot(VOCsum,squeeze(netO3(i,j,:)),'Color',cmap(j,:),'LineWidth',2); hold on;
        end
        imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3_vs_VOCsum.png');
        title('Net O_3 production');
        leg = legend('5 ppt','25 ppt','50 ppt','100 ppt','250 ppt','500 ppt','750 ppt','1 ppb',...
    '2.5 ppb','5 ppb','10 ppb','Location','eastoutside');
        legv = get(leg,'title');
        set(legv,'string','NOx');
        xlabel('VOC, ppb');
        ylabel('O_3, ppb');
        set(gcf,'visible','off')
        print(gcf,'-dpng','-r300',imgname);
end
%% Net ANs production vs NOx and VOC
clc;
i = 2;
outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
if exist(outdir,'dir') ~= 7; mkdir(outdir); end
for j = 1:numel(NOx) % net ANs production
    for k = 1:numel(VOC)
        ANs(j,k,:) = mixrat(i,j,k,:,15)+mixrat(i,j,k,:,24)+mixrat(i,j,k,:,36)+mixrat(i,j,k,:,37)+...
            mixrat(i,j,k,:,48)+mixrat(i,j,k,:,49)+mixrat(i,j,k,:,58)+mixrat(i,j,k,:,59)+...
            mixrat(i,j,k,:,73)+mixrat(i,j,k,:,74)+mixrat(i,j,k,:,75)+...
            mixrat(i,j,k,:,88)+mixrat(i,j,k,:,89)+mixrat(i,j,k,:,90);
    end
end
figure
contourf(NOx,VOCsum,ANs(:,:,end)'); colorbar; colormap(paruly)
imgname = strcat(outdir,'/',part,'_',AN{i},'_netANs.png');
title('Net RONO_2 production');
xlabel('NOx, ppt');
ylabel('VOC, ppb');
set(gca,'XScale','log');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Net ANs vs NOx
clc;
i = 2;
outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
if exist(outdir,'dir') ~= 7; mkdir(outdir); end
figure
for k = 1:numel(VOC) % net ANs vs NOx
    plot(NOx,ANs(:,k,end),'Color',cvec(k,:),'LineWidth',2); hold on;
end
imgname = strcat(outdir,'/',part,'_',AN{i},'_netANs_vs_NOx.png');
title('Net RONO_2 production');
leg = legend('1781.52','1809.92','1838.32','1866.71','1895.11','1923.51','1951.91','1980.31',...
    '2008.70','2037.10','2065.50','Location','eastoutside');
legv = get(leg,'title');
set(legv,'string','\Sigma VOCs, ppb');
xlabel('NOx, ppt');
ylabel('\Sigma RONO_2, ppb');
set(gca,'XScale','log');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Net ANs vs VOCsum
clc;
i = 2;
outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
if exist(outdir,'dir') ~= 7; mkdir(outdir); end
figure
for j = 1:numel(NOx) % net ANs vs VOCsum
    plot(VOCsum,ANs(j,:,end),'Color',cvec(j,:),'LineWidth',2); hold on;
end
imgname = strcat(outdir,'/',part,'_',AN{i},'_netANs_vs_VOCsum.png');
title('Net RONO_2 production');
leg = legend('5 ppt','25 ppt','50 ppt','100 ppt','250 ppt','500 ppt','750 ppt','1 ppb',...
    '2.5 ppb','5 ppb','10 ppb','Location','eastoutside');
legv = get(leg,'title');
set(legv,'string','NOx');
xlabel('VOC, ppb');
ylabel('\Sigma RONO_2, ppb');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
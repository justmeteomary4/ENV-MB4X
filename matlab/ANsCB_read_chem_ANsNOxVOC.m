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
NOx = [5 25 50 100 250 500 750 1000 2500 5000 10000 50000 100000];
VOC = [0 1 2 3 4 5 6 7 8 9 10 11];
comp = {'CO' 'CH4' 'CH4AN' 'C2H6' 'C2H6AN' 'C3H8' 'C3H8AN' 'nC4H10' 'nC4H10AN' ...
    'iC4H10' 'iC4H10AN' 'nC5H12' 'nC5H12AN' 'iC5H12' 'iC5H12AN'};
for i = 1:numel(AN) % calc numden and mixrat
    for j = 1:numel(NOx)
        for k = 1:numel(VOC)
            if i == 2 && k ==1 
                numden(i,j,k,:,:) = NaN;
                mixrat(i,j,k,:,:) = NaN;
            else
                aggr_array = [];
                for icomp = 1:numel(comp)
                    fname = [indir,'/',part,'_',num2str(AN{i}),'_',num2str(NOx(j)),'_',num2str(VOC(k)),'_',comp{icomp},'.dat'];
                    f = importdata(fname);
                    aggr_array = horzcat(aggr_array, f);
                end
                numden(i,j,k,:,:) = aggr_array;               % number density
                mixrat(i,j,k,:,:) = aggr_array./M*1.0e9; % mixing ratio
            end
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
VOCsum = [100 1781.52 1809.92 1838.32 1866.71 1895.11 1923.51 1951.91 1980.31 2008.70 2037.10 2065.50];
onoff = {'OFF' 'ON'};
%% Plot all in one figure
clc; plotting = 0; % 0 - don't plot, 1 - plot
fig=figure;
for i = 1:numel(AN) % print all in one .png + calc sums of radicals and ANs
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

switch plotting
    case 1
        nrows = 3; ncols = 7;
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
end
%% Net O3 production vs NOx and VOC depending on ANs presence (with/without)
clc;
VOCppbC(1) = mixrat(1,1,1,1,8)*1; % CO only
for k = 2:numel(VOC) % VOCppbC(2:end)
    VOCppbC(k) = mixrat(1,1,k,1,8)*1+mixrat(1,1,k,1,10)*1+mixrat(1,1,k,1,16)*2+...
        mixrat(1,1,k,1,25)*3+mixrat(1,1,k,1,38)*4+mixrat(1,1,k,1,50)*4+mixrat(1,1,k,1,60)*5+...
        mixrat(1,1,k,1,76)*5;
end
for i = 1:numel(AN)
    outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
    if exist(outdir,'dir') ~= 7; mkdir(outdir); end
    for j = 1:numel(NOx)
        for k = 1:numel(VOC)
            netO3(i,j,k) = (mixrat(i,j,k,end,1)-mixrat(i,j,k,1,1));
            netO3rate(i,j,k) = (mixrat(i,j,k,end,1)-mixrat(i,j,k,1,1))/24;
            endHO2RO2(i,j,k) = mixrat(i,j,k,end,6)+mixrat(i,j,k,end,13)+mixrat(i,j,k,end,18)+...
                mixrat(i,j,k,end,27)+mixrat(i,j,k,end,29)+mixrat(i,j,k,end,41)+mixrat(i,j,k,end,42)+...
                mixrat(i,j,k,end,53)+mixrat(i,j,k,end,54)+mixrat(i,j,k,end,64)+mixrat(i,j,k,end,65)+...
                mixrat(i,j,k,end,66)+mixrat(i,j,k,end,80)+mixrat(i,j,k,end,81)+mixrat(i,j,k,end,82);
        end
    end
    pic = 5;
    figure
    switch pic
        case 0 % netO3 NOx = 5 ppt - 100 ppb with 'inorganics only', transposed (Y = NOx)
            contourf(NOx,VOCsum,squeeze(netO3(i,:,:))'); colorbar; colormap(paruly) % transposed
        case 1 % netO3rate NOx = 1 ppb -100 ppb with 'inorganics only'
            contourf(VOCppbC,NOx(8:end)/10e3,squeeze(netO3rate(i,8:end,:))); colorbar; colormap(paruly)
            imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3rate_withINORG_NOx_1ppb_100ppb.png');
            title(['Net O_3 production rate with RONO_2 chemistry ',onoff{i}]);
            xlabel('VOC, ppbC');
            ylabel('NOx, ppb'); set(gca,'YScale','log')
        case 2 % netO3rate NOx = 5 ppt - 100 ppb with 'inorganics only'
            contourf(VOCppbC,NOx,squeeze(netO3rate(i,:,:))); colorbar; colormap(paruly)
            imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3rate_withINORG_NOx_5ppt_100ppb.png');
            title(['Net O_3 production rate with RONO_2 chemistry ',onoff{i}]);
            xlabel('VOC, ppbC');
            ylabel('NOx, ppt'); set(gca,'YScale','log')
        case 3 % netO3rate NOx = 5 ppt - 10 ppb without 'inorganics only'
            contourf(VOCppbC,NOx(1:11),squeeze(netO3rate(i,1:11,:))); colorbar; colormap(paruly)
            imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3rate_withINORG_NOx_5ppt_10ppb.png');
            title(['Net O_3 production rate with RONO_2 chemistry ',onoff{i}]);
            xlabel('VOC, ppbC');
            ylabel('NOx, ppt'); set(gca,'YScale','log')
        case 4 % endOH NOx = 1 ppb - 100 ppb with 'inorganics only'
            contourf(VOCppbC,NOx(8:end)/10e3,squeeze(mixrat(i,8:end,:,end,3))); colorbar; colormap(paruly)
            imgname = strcat(outdir,'/',part,'_',AN{i},'_endOH_withINORG_NOx_1ppb_100ppb.png');
            title(['OH mixing ratio with RONO_2 chemistry ',onoff{i}]);
            xlabel('VOC, ppbC');
            ylabel('NOx, ppb'); set(gca,'YScale','log')
        case 5 % endHO2RO2 NOx = 1 ppb - 100 ppb with 'inorganics only'
            contourf(VOCppbC,NOx(8:end),squeeze(endHO2RO2(i,8:end,:))); colorbar; colormap(paruly)
            imgname = strcat(outdir,'/',part,'_',AN{i},'_endHO2RO2_withINORG_NOx_5ppt_100ppb.png');
            title(['HO_2+RO_2 mixing ratio with RONO_2 chemistry ',onoff{i}]);
            xlabel('VOC, ppbC');
            ylabel('NOx, ppb'); set(gca,'YScale','log')
    end
%     set(gca, 'CLim', [min(min(min(netO3))), max(max(max(netO3)))]);
    set(gcf,'visible','off')
    print(gcf,'-dpng','-r300',imgname);
end
%% Difference in net O3 production vs NOx and VOC between experiments with and without ANs
clc;
i = 2;
outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
if exist(outdir,'dir') ~= 7; mkdir(outdir); end
for j = 1:numel(NOx)
    for k = 2:numel(VOC)
        netO3ratediff(j,k) = netO3rate(2,j,k)-netO3rate(1,j,k);
        netO3mixratdiff(j,k) = netO3(2,j,k)-netO3(1,j,k);
    end
end
pic = 1;
figure
switch pic
    case 1 % difference in netO3rate NOx = 5 ppt - 100 ppb no 'inorganics only'
        contourf(VOCppbC,NOx,netO3ratediff); colorbar; colormap(paruly)
        imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3ratediff_noINORG_NOx_5ppt_100ppb.png');
        title('Difference in net O_3 production rate');
        xlabel('VOC, ppb');
        ylabel('NOx, ppt'); set(gca,'YScale','log')        
    case 2 % difference in netO3mixrat NOx = 5 ppt - 100 ppb no 'inorganics only'
        contourf(VOCppbC,NOx,netO3mixratdiff); colorbar; colormap(paruly)
        imgname = strcat(outdir,'/',part,'_',AN{i},'_netO3mixratdiff_noINORG_NOx_5ppt_100ppb.png');
        title('Difference in net O_3 production');
        xlabel('VOC, ppb');
        ylabel('NOx, ppt'); set(gca,'YScale','log')
end
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
%% For model validation: timeseries of main species (noAN)
clc; plotting = 1; % 0 - don't plot, 1 - plot;
ext = '.eps'; % '.png'
driver = '-depsc'; % '-dpng'
xhsize = 30; yhsize = 30; ticksize = 30;
switch plotting %timeseries of main species (noAN)
    case 1
        i = 1; % for noAN only
        outdir = strcat(common_outdir,'/ANsNOxVOC/',AN{i});
        if exist(outdir,'dir') ~= 7; mkdir(outdir); end
        figure
        plot(squeeze(mixrat(1,3,2,:,1)),'b','LineWidth',3); hold on;
        plot(squeeze(mixrat(1,3,12,:,1)),'--b','LineWidth',3); hold on;
        plot(squeeze(mixrat(1,10,2,:,1)),'r','LineWidth',3); hold on;
        plot(squeeze(mixrat(1,10,12,:,1)),'--r','LineWidth',3);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_O3_vs_time',ext); %th = title('O_3'); set(th,'FontSize',18);
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);
        
        figure
        plot(squeeze(mixrat(1,3,2,:,2)),'b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,3,12,:,2)),'--b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,2,:,2)),'r','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,12,:,2)),'--r','LineWidth',2);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_O1D_vs_time',ext); %title('O(^1D)');
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);
        
        figure
        plot(squeeze(mixrat(1,3,2,:,3)),'b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,3,12,:,3)),'--b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,2,:,3)),'r','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,12,:,3)),'--r','LineWidth',2);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_OH_vs_time',ext); %title('OH');
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);
        
        figure
        time = 1:tN; dummy = ones(tN)*NaN;
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        plot(squeeze(mixrat(1,3,2,:,4)),'b','LineWidth',2); hold on;
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb','Color','k');
        set(gca,'XTick',xx,'XTickLabel',xxlab)
        plot(squeeze(mixrat(1,3,12,:,4)),'--b','LineWidth',2); hold on;
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb','Color','k');
        set(gca,'XTick',xx,'XTickLabel',xxlab)
        [ax,h11,h12]=plotyy(time,dummy,time,squeeze(mixrat(1,10,2,:,4))); hold on;
        set(ax,'XTick',xx,'XTickLabel',xxlab); set(ax,'xlim',xlimits);
        [ax,h21,h22]=plotyy(time,dummy,time,squeeze(mixrat(1,10,12,:,4)));
        set(ax,'XTick',xx,'XTickLabel',xxlab); set(ax,'xlim',xlimits);
        set(ax,{'ycolor'},{'b';'r'}); % % {'b';'r'}
        set(ax,'fontsize',ticksize)
        set(h12,'LineWidth',2,'LineStyle','-','Color','r');
        set(h22,'LineWidth',2,'LineStyle','--','Color','r');
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_NO_vs_time',ext); %title('NO');
        set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);
        
        figure
        time = 1:tN; dummy = ones(tN)*NaN;
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        plot(squeeze(mixrat(1,3,2,:,5)),'b','LineWidth',2); hold on;
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb','Color','k');
        set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize); set(gca,'XTick',xx,'XTickLabel',xxlab)
        plot(squeeze(mixrat(1,3,12,:,5)),'--b','LineWidth',2); hold on;
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb','Color','k');
        set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize); set(gca,'XTick',xx,'XTickLabel',xxlab)
        [ax,h11,h12]=plotyy(time,dummy,time,squeeze(mixrat(1,10,2,:,5))); hold on;
        set(ax,'XTick',xx,'XTickLabel',xxlab); set(ax,'xlim',xlimits);
        [ax,h21,h22]=plotyy(time,dummy,time,squeeze(mixrat(1,10,12,:,5)));
        set(ax,'XTick',xx,'XTickLabel',xxlab); set(ax,'xlim',xlimits);
        set(ax,{'ycolor'},{'b';'r'}); % {'b';'r'}
        set(ax,'fontsize',ticksize)
        set(h12,'LineWidth',2,'LineStyle','-','Color','r');
        set(h22,'LineWidth',2,'LineStyle','--','Color','r');
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_NO2_vs_time',ext); %title('NO_2');
        set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);

        figure
        plot(squeeze(mixrat(1,3,2,:,6)),'b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,3,12,:,6)),'--b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,2,:,6)),'r','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,12,:,6)),'--r','LineWidth',2);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_HO2_vs_time',ext); %title('HO_2');
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);

        figure
        plot(squeeze(mixrat(1,3,2,:,7)),'b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,3,12,:,7)),'--b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,2,:,7)),'r','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,12,:,7)),'--r','LineWidth',2);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_H2O2_vs_time',ext); %title('H_2O_2');
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);

        figure
        plot(squeeze(mixrat(1,3,2,:,8)),'b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,3,12,:,8)),'--b','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,2,:,8)),'r','LineWidth',2); hold on;
        plot(squeeze(mixrat(1,10,12,:,8)),'--r','LineWidth',2);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_CO_vs_time',ext); %title('CO');
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);
        
        RO2(1,3,2,:) = mixrat(1,3,2,:,13)+mixrat(1,3,2,:,18)+mixrat(1,3,2,:,27)+mixrat(1,3,2,:,29)+...
            mixrat(1,3,2,:,41)+mixrat(1,3,2,:,42)+mixrat(1,3,2,:,53)+mixrat(1,3,2,:,54)+...
            mixrat(1,3,2,:,64)+mixrat(1,3,2,:,65)+mixrat(1,3,2,:,66)+...
            mixrat(1,3,2,:,80)+mixrat(1,3,2,:,81)+mixrat(1,3,2,:,82);
        RO2(1,3,12,:) = mixrat(1,3,12,:,13)+mixrat(1,3,12,:,18)+mixrat(1,3,12,:,27)+mixrat(1,3,12,:,29)+...
            mixrat(1,3,12,:,41)+mixrat(1,3,12,:,42)+mixrat(1,3,12,:,53)+mixrat(1,3,12,:,54)+...
            mixrat(1,3,12,:,64)+mixrat(1,3,12,:,65)+mixrat(1,3,12,:,66)+...
            mixrat(1,3,12,:,80)+mixrat(1,3,12,:,81)+mixrat(1,3,12,:,82);
        RO2(1,10,2,:) = mixrat(1,10,2,:,13)+mixrat(1,10,2,:,18)+mixrat(1,10,2,:,27)+mixrat(1,10,2,:,29)+...
            mixrat(1,10,2,:,41)+mixrat(1,10,2,:,42)+mixrat(1,10,2,:,53)+mixrat(1,10,2,:,54)+...
            mixrat(1,10,2,:,64)+mixrat(1,10,2,:,65)+mixrat(1,10,2,:,66)+...
            mixrat(1,10,2,:,80)+mixrat(1,10,2,:,81)+mixrat(1,10,2,:,82);
        RO2(1,10,12,:) = mixrat(1,10,12,:,13)+mixrat(1,10,12,:,18)+mixrat(1,10,12,:,27)+mixrat(1,10,12,:,29)+...
            mixrat(1,10,12,:,41)+mixrat(1,10,12,:,42)+mixrat(1,10,12,:,53)+mixrat(1,10,12,:,54)+...
            mixrat(1,10,12,:,64)+mixrat(1,10,12,:,65)+mixrat(1,10,12,:,66)+...
            mixrat(1,10,12,:,80)+mixrat(1,10,12,:,81)+mixrat(1,10,12,:,82);
        figure
        plot(squeeze(RO2(1,3,2,:)),'b','LineWidth',2); hold on;
        plot(squeeze(RO2(1,3,12,:)),'--b','LineWidth',2); hold on;
        plot(squeeze(RO2(1,10,2,:)),'r','LineWidth',2); hold on;
        plot(squeeze(RO2(1,10,12,:)),'--r','LineWidth',2);
        imgname = strcat(outdir,'/',part,'_',AN{i},'_valid_50ppt5000ppt_RO2_vs_time',ext); %title('RO_2');
        xlimits = [0 tN]; xx =0:(tN)/2:tN; xxlab = num2str(xx'/4); xlim(gca,xlimits);
        xh = xlabel('hour'); set(xh,'FontSize',xhsize); yh = ylabel('ppb'); set(yh,'FontSize',yhsize); set(gca,'FontSize',ticksize)
        set(gca,'XTick',xx,'XTickLabel',xxlab); set(gcf,'visible','off')
        print(gcf,driver,'-r300',imgname);
end
close all; disp('done')
% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '';
outdir = 'ANsCB_pics';
fname = {'chem_0_01' 'chem_0_02' 'chem_0_03' 'chem_0_04' 'chem_0_05' ...
              'chem_1_01' 'chem_1_02' 'chem_1_03' 'chem_1_04' 'chem_1_05'};
for fn = 1:length(fname)
    fnamelong = [indir,'/',fname{fn},'.dat'];
    f = importdata(fnamelong);
    for i = 1:numel(f.colheaders)
        td{fn,i} = f;
    end
end
%% Calculate differencies in O3 production between experiments
diffO3(:,1) = td{6,1}(:,1)-td{1,1}(:,1);
diffO3(:,2) = td{7,1}(:,1)-td{2,1}(:,1);
diffO3(:,3) = td{8,1}(:,1)-td{3,1}(:,1);
diffO3(:,4) = td{9,1}(:,1)-td{4,1}(:,1);
diffO3(:,5) = td{10,1}(:,1)-td{5,1}(:,1);
%% Plot mixing ratios
nrows = 3;
ncols = 2;
fig=figure;
diffexp = {'101-001' '102-002' '103-003' '104-004' '105-005'};
for isub = 1:length(diffexp)
    subplot(nrows,ncols,isub); plot(diffO3(:,isub)); title(diffexp{isub});
% subplot(nrows,ncols,1); plot(td{1,1}(:,1)); title('inorg+CH4');
% subplot(nrows,ncols,2); plot(td{2,1}(:,1)); title('...+C2H6');
% subplot(nrows,ncols,3); plot(td{3,1}(:,1)); title('...+C3H8');
% subplot(nrows,ncols,4); plot(td{4,1}(:,1)); title('...+NC4H10');
% subplot(nrows,ncols,5); plot(td{5,1}(:,1)); title('...+NC5H12');
% subplot(nrows,ncols,6); plot(td{6,1}(:,1)); title('...+CH3NO3'); % top
% subplot(nrows,ncols,7); plot(td{7,1}(:,1)); title('...+C2H5NO3'); % top+left
% subplot(nrows,ncols,8); plot(td{8,1}(:,1)); title('...+IC3H7NO3+NC3H7NO3');
% subplot(nrows,ncols,9); plot(td{9,1}(:,1)); title('...+NC4H9NO3+SC4H9NO3');
% subplot(nrows,ncols,10); plot(td{10,1}(:,1)); title('...+PEANO3+PEBNO3+PECNO3');
end
faxes = findobj(fig,'Type','Axes');
    for i=1:length(faxes)
        xlabel(faxes(i),'sec','FontSize',8)
        ylabel(faxes(i),'ppb','FontSize',8)
        set(faxes(i),'FontSize',7)
        ylim(faxes(i),[min(min(min(min(min(diffO3))))) 0]);
        xlim(faxes(i),[0 length(td)]);
    end
ha = axes('Position',[0.5 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized','clipping','off');
titlemain = text(0,1,'\bf delta O_3','HorizontalAlignment','center','VerticalAlignment','top');
% legend('001,002,003,004 - without ANs','101,102,103,104,105 - with ANs');
imgname = strcat(outdir,'/','chem_diffO3.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
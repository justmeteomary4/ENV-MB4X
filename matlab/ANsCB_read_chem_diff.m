% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
fname = {'chem_0_00' 'chem_0_01' 'chem_0_02' 'chem_1_01' 'chem_1_02'};
%             inorganic    ing+CH4     ing+CH4+C2H6 ing+CH4+AN   ing+CH4+C2H6+ANs  
%             1                2                 3                4                5
for fn = 1:length(fname)
    fnamelong = [indir,'/',fname{fn},'.dat'];
    f = importdata(fnamelong,' ',2);
    for i = 1:numel(f.colheaders)
        td1{fn,i} = f.data;
        header{fn,i} = f.colheaders{i}(2:end); % read headers from 2nd letter
    end
end
plnames = {'O3' 'O1D' 'OH' 'NO' 'NO2' 'HO2' 'H2O2' 'CO' 'CH4' 'C2H6' 'CH3O' 'CH3O2' 'C2H5O' 'C2H5O2' 'HCHO' 'CH3NO3' 'C2H5NO3'};
nrows = 3;
ncols = 2;
xend = 3600*24;%length(td1);
%                                                                                                                       Effect
diffO3_001_000 = td1{2,1}(1:xend,1)-td1{1,1}(1:xend,1); % CH4-inorganic                  CH4 only
diffO3_002_000 = td1{3,1}(1:xend,1)-td1{1,1}(1:xend,1); % CH4+C2H6-inorganic        CH4+C2H6 (can calc C2H6 only)
diffO3_101_000 = td1{4,1}(1:xend,1)-td1{1,1}(1:xend,1); % CH4+AN-inorganic           CH4+AN (need CH4+AN-CH4)
diffO3_102_000 = td1{5,1}(1:xend,1)-td1{1,1}(1:xend,1); % CH4+C2H6+ANs-inorganic
diffO3_101_001 = td1{4,1}(1:xend,1)-td1{2,1}(1:xend,1); % CH4+AN-CH4                         methyl nitrate
diffO3_102_002 = td1{5,1}(1:xend,1)-td1{3,1}(1:xend,1); % CH4+C2H6+ANs-(CH4+C2H6)  ethyle nitrate
%% Plot mixing ratios
fig=figure;
subplot(3,2,1); plot(td1{2,1}(1:xend,1)); title('inorg+CH4');
subplot(3,2,2); plot(td1{3,1}(1:xend,1)); title('inorg+CH4+C2H6');
subplot(3,2,3); plot(td1{3,1}(1:xend,1)); title('inorg+CH4+CH3NO3');
subplot(3,2,4); plot(td1{5,1}(1:xend,1)); title('inorg+CH4+C2H6+CH3NO3+C2H5NO3');
subplot(3,2,5); plot(diffO3_101_001); title('CH3NO3'); % inorg+CH4+CH3NO3-(inorg+CH4)
subplot(3,2,6); plot(diffO3_102_002); title('CH3NO3+C2H5NO3'); %inorg+CH4C2H6+CH3NO3+C2H5NO3-(inorg+CH4C2H6)
ha = axes('Position',[0.5 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized','clipping','off');
titlemain = text(0.5,1,'\bf O3','HorizontalAlignment','center','VerticalAlignment','top');
faxes = findobj(fig,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',9)
    ylabel(faxes(i),'ppb','FontSize',9)
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/','chem_diff.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
fname = 'chem_1';
indir = '../';
outdir = 'ANsCB_pics/';
name = {'O3' 'HO' 'NO' 'NO2' 'HO2' 'H2O2' 'CH3O' 'CH3O2' 'CH3OOH' 'CH3ONO2' 'HCHO' 'CO' 'HCOflux' 'CH3Oflux'};
format = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f';
fid1 = fopen([indir,'/',fname,'.dat'],'r');
rd1 = textscan(fid1,format,'headerlines',2);
fclose(fid1);
td1 = cell2mat(rd1);
%% Calculate number of carbon bonds,
% i.e. fluxes through reactions where carbon bond is broken and peroxy radical is
% produced, namely:
% HCO+O2 = CO+HO2
% CH3O+O2 = HCHO+HO2
CB = td1(:,13) + td1(:,14);
%% Plot mixing ratios
xend = 3600*24;%length(td1);
f=figure;
subplot(3,4,1); plot(td1(:,1),'LineWidth',2,'Color','r'); title(name{1});
subplot(3,4,2); plot(td1(:,2),'LineWidth',2,'Color','r'); title(name{2});
subplot(3,4,3); plot(td1(:,3),'LineWidth',2,'Color','r'); title(name{3});
subplot(3,4,4); plot(td1(:,4),'LineWidth',2,'Color','r'); title(name{4});
subplot(3,4,5); plot(td1(:,5),'LineWidth',2); title(name{5});
subplot(3,4,6); plot(td1(:,6),'LineWidth',2); title(name{6});
subplot(3,4,7); plot(td1(:,7),'LineWidth',2); title(name{7});
subplot(3,4,8); plot(td1(:,8),'LineWidth',2); title(name{8});
subplot(3,4,9); plot(td1(:,9),'LineWidth',2); title(name{9});
subplot(3,4,10); plot(td1(:,10),'LineWidth',2,'Color','r'); title(name{10});
subplot(3,4,11); plot(td1(:,11),'LineWidth',2,'Color','r'); title(name{11});
subplot(3,4,12); plot(CB,'LineWidth',2); title('CB'); % carbon bonds
faxes = findobj(f,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',9)
    ylabel(faxes(i),'ppb','FontSize',9)
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname= strcat(outdir,fname,'_pic_1','.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
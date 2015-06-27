% Read and plot resulting mixing ratios from ANsCB model
%% Read mixing ratios
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
fname = 'flux_0_00';
fnamelong = [indir,'/',fname,'.dat'];
f = importdata(fnamelong,' ',2);
td = f.data;
for i = 1:numel(f.colheaders)
    header{i} = f.colheaders{i}(2:end); % read headers from 2nd letter
end
fluxnames = {'KO3' 'KO12' 'KO13' 'KO25' 'KO36' 'KO53' 'KO86' 'KO95' 'KO97' 'KO100' ...
    'KO120' 'KOMCM1' 'KO139A' 'KO139B' 'KO197A' 'KO197B' 'KO209' ...
    'KO40' 'KOMCM2' 'KO211'};
cvec = {'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r'};
nrows = 4;
ncols = 5;
%% Plot fluxes through each organic reaction
xend = 3600*24;%length(td1);
fig=figure;
for isub = 1:numel(fluxnames)
    j = find(ismember(header,fluxnames{isub}));
    subplot(nrows,ncols,isub); plot(td(:,j),'LineWidth',2,'Color',cvec{isub}); title(header{j});
end
faxes = findobj(fig,'Type','Axes');
for i=1:length(faxes)
    xlabel(faxes(i),'sec','FontSize',9)
    ylabel(faxes(i),'molecules s-1','FontSize',9) %flux
    set(faxes(i),'FontSize',7)
    xlim(faxes(i),[0 xend]);
end
imgname = strcat(outdir,'/',fname,'_pic','.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
%% Calculate number of carbon bonds in reactants (CO+CH4)
cbLOST = 4*td(:,1)+td(:,2);
% Rectants
reac{1} = 1*td(:,2); % CO
reac{2} =  4*td(:,1); % CH4
reac{3} = 2*td(:,9); % CH2OH
reac{4} = zeros(length(td),1); % CH2OOH
reac{5} = 3*td(:,7); % CH3
reac{6} = 3*td(:,10); % CH3O
reac{7} = 3*(td(:,6)+td(:,11)+td(:,12)+2*td(:,13)+2*td(:,14)+td(:,19)); % CH3O2
reac{8} = 3*td(:,4); % CH3OH
reac{9} = 3*(td(:,5)+td(:,17)); % CH3OOH
reac{10} = 1*td(:,8); % HCO
reac{11} = 2*(td(:,3)+td(:,15)+td(:,16)); % HCHO
reac{12} = 3*(td(:,18)+td(:,20)); % CH3ONO2
% Products
prod{1} = 1*(td(:,8)+td(:,16)); % CO
prod{2} = zeros(length(td),1); % CH4
prod{3} = 2*(0.85*td(:,4)); % CH2OH
prod{4} = 2*(0.35*td(:,5)); % CH2OOH
prod{5} = 3*td(:,1); % CH3
prod{6} = 3*(0.15*td(:,4)+td(:,11)+td(:,12)+2*td(:,14)+td(:,17)+td(:,20)); % CH3O
prod{7} = 3*(0.65*td(:,5)+td(:,7)); % CH3O2
prod{8} = 3*td(:,13); % CH3OH
prod{9} = 3*0.9*td(:,6); % CH3OOH
prod{10} = 1*(td(:,3)+td(:,15)); % HCO
prod{11} = 2*(0.1*td(:,6)+td(:,9)+td(:,10)+td(:,13)+td(:,18)); % HCHO
prod{12} = 3*td(:,19); % CH3ONO2
compnames = {'CO' 'CH4' 'CH2OH' 'CH2OOH' 'CH3' 'CH3O' 'CH3O2' 'CH3OH' ...
    'CH3OOH' 'HCO' 'HCHO' 'CH3ONO2'};
step = 'sec';

% figure; plot(reac_CO,'b'); hold on; plot(prod_CO,'r'); title('CO'); hold off;
% figure; plot(reac_CH4,'b'); title('CH4');
% figure; plot(reac_CH2OH,'b'); hold on; plot(prod_CH2OH,'r'); title('CH2OH'); hold off;
% figure; plot(reac_CH2OOH,'b'); hold on; plot(prod_CH2OOH,'r'); title('CH2OOH'); hold off;
% figure; plot(reac_CH3,'b'); hold on; plot(prod_CH3,'r'); title('CH3'); hold off;
% figure; plot(reac_CH3O,'b'); hold on; plot(prod_CH3O,'r'); title('CH3O'); hold off;
% figure; plot(reac_CH3O2,'b'); hold on; plot(prod_CH3O2,'r'); title('CH3O2'); hold off;
% figure; plot(reac_CH3OH,'b'); hold on; plot(prod_CH3OH,'r'); title('CH3OH'); hold off;
% figure; plot(reac_CH3OOH,'b'); hold on; plot(prod_CH3OOH,'r'); title('CH3OOH'); hold off;
% figure; plot(reac_HCO,'b'); hold on; plot(prod_HCO,'r'); title('HCO'); hold off;
% figure; plot(reac_HCHO,'b'); hold on; plot(prod_HCHO,'r'); title('HCHO'); hold off;
% figure; plot(reac_CH3ONO2,'b'); hold on; plot(prod_CH3ONO2,'r'); title('CH3ONO2'); hold off;
for in = 1:length(compnames)
    figure;
    plot(reac{in},'b'); hold on; plot(prod{in},'r'); title(compnames{in}); hold off;
    imgname = strcat(outdir,'/',fname,'_',compnames{in},'.png');
    xlabel(strcat('Time, ',step)); xlim([0 length(td)]);
    ylabel('number of carbon bonds');
    legend('lost','produced','Location','southeast');
    set(gcf,'visible','off')
    print(gcf,'-dpng','-r300',imgname);
end
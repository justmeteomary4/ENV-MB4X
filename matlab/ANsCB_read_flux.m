% Read and plot resulting 'fluxes' from ANsCB model
%% Read nett reaction rates (RF % KF : A = B, where RF = KF*A)
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
fname = 'flux_0_01';
fnamelong = [indir,'/',fname,'.dat'];
f = importdata(fnamelong,' ',2);
RF = f.data;
for i = 1:numel(f.colheaders)
    header{i} = f.colheaders{i}(2:end); % read headers from 2nd letter
end
RFnames = {'RCH41' 'RCH42' 'RCH43' 'RCH44' 'RCH45' 'RCH46' 'RCH47' 'RCH48' 
    'RCH49' 'RCH410' 'RCH411' 'RCH412' 'RCH413' 'RCH414' 'RCH415'};
% RFnames = {'KO3' 'KO12' 'KO13' 'KO25' 'KO36' 'KO53' 'KO86' 'KO95' 'KO97' 'KO100' ...
%     'KO120' 'KOMCM1' 'KO139A' 'KO139B' 'KO197A' 'KO197B' 'KO209' ...
%     'KO40' 'KOMCM2' 'KO211'};
% cvec = {'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r' 'r'};
nrows = 4;
ncols = 5;
%% Plot RF of organic reactions
% xend = 3600*24;%length(td1);
% fig=figure;
% for isub = 1:numel(RFnames)
%     j = find(ismember(header,RFnames{isub}));
%     subplot(nrows,ncols,isub); plot(RF(:,j),'LineWidth',2,'Color','r'); title(header{j});
% end
% faxes = findobj(fig,'Type','Axes');
% for i=1:length(faxes)
%     xlabel(faxes(i),'sec','FontSize',9)
%     ylabel(faxes(i),'molecules s-1','FontSize',9)
%     set(faxes(i),'FontSize',7)
%     xlim(faxes(i),[0 xend]);
% end
% imgname = strcat(outdir,'/',fname,'_RF','.png');
% set(gcf,'visible','off')
% print(gcf,'-dpng','-r300',imgname);
%% Calculate number of carbon bonds (CB)
% Initial number of CBs in the system = number of carbons * number density
ndCO = 2.431*10^(12);
ndCH4 = 4.375*10^(13); 
cb_init = 1*ndCO+4*ndCH4;
  % Rectant (left hand side of reaction)
% cbreac_left(1,:) = 1*RF(:,2); % CO
% cbreac_left(2,:) = ;
% 
% cbreac_left{1,1} = 1*RF(:,2); % CO
% cbreac_left{1,2} = 4*RF(:,1); % CH4
% cbreac_left{1,3} = 2*RF(:,9); % CH2OH
% cbreac_left{1,4} = zeros(length(RF),1); % CH2OOH
% cbreac_left{1,5} = 3*RF(:,7); % CH3
% cbreac_left{1,6} = 3*RF(:,10); % CH3O
% cbreac_left{1,7} = 3*(RF(:,6)+RF(:,11)+RF(:,12)+2*RF(:,13)+2*RF(:,14)+RF(:,19)); % CH3O2
% cbreac_left{1,8} = 3*RF(:,4); % CH3OH
% cbreac_left{1,9} = 3*(RF(:,5)+RF(:,17)); % CH3OOH
% cbreac_left{1,10} = 1*RF(:,8); % HCO
% cbreac_left{1,11} = 2*(RF(:,3)+RF(:,15)+RF(:,16)); % HCHO
% cbreac_left{1,12} = 3*(RF(:,18)+RF(:,20)); % CH3ONO2
% % Product (right hand side of reaction)
cbreac_right(1,:) = 1*RF(3:,); % CO
cbreac_right(2,:) = 4*zeros(length(RF),1); % CH4
cbreac_right(3,:) = 2*RF(); %  HCHO
cbreac_right(4,:) = 3*RF(); % CH3O
cbreac_right(5,:) = 3*RF(); % CH3O2
cbreac_right(6,:) = 3*RF(); % CH3OH
cbreac_right(7,:) = 3*RF(); % CH3OOH
cbreac_right(8,:) = 3*RF(); % CH3NO3
% cbreac_righ{1,1} = 1*(RF(:,8)+RF(:,16)); % CO
% cbreac_righ{1,2} = zeros(length(RF),1); % CH4
% cbreac_righ{1,3} = 2*(0.85*RF(:,4)); % CH2OH
% cbreac_righ{1,4} = 2*(0.35*RF(:,5)); % CH2OOH
% cbreac_righ{1,5} = 3*RF(:,1); % CH3
% cbreac_righ{1,6} = 3*(0.15*RF(:,4)+RF(:,11)+RF(:,12)+2*RF(:,14)+RF(:,17)+RF(:,20)); % CH3O
% cbreac_righ{1,7} = 3*(0.65*RF(:,5)+RF(:,7)); % CH3O2
% cbreac_righ{1,8} = 3*RF(:,13); % CH3OH
% cbreac_righ{1,9} = 3*0.9*RF(:,6); % CH3OOH
% cbreac_righ{1,10} = 1*(RF(:,3)+RF(:,15)); % HCO
% cbreac_righ{1,11} = 2*(0.1*RF(:,6)+RF(:,9)+RF(:,10)+RF(:,13)+RF(:,18)); % HCHO
% cbreac_righ{1,12} = 3*RF(:,19); % CH3ONO2
% cbreac_diff = cellfun(@minus,cbreac_righ,cbreac_left,'UniformOutput',false); % right-left
% Number of CBs in the system
cbsys_lost = sum(cbreac_left,1); %sum by 1st dimension

cbsys_lost = cbreac_left{1,1}+cbreac_left{1,2}+cbreac_left{1,3}+cbreac_left{1,4}+cbreac_left{1,5}+...
    cbreac_left{1,6}+cbreac_left{1,7}+cbreac_left{1,8}+cbreac_left{1,9}+cbreac_left{1,10}+...
    cbreac_left{1,11}+cbreac_left{1,12};
cbsys_prod = cbreac_righ{1,1}+cbreac_righ{1,2}+cbreac_righ{1,3}+cbreac_righ{1,4}+cbreac_righ{1,5}+...
    cbreac_righ{1,6}+cbreac_righ{1,7}+cbreac_righ{1,8}+cbreac_righ{1,9}+cbreac_righ{1,10}+...
    cbreac_righ{1,11}+cbreac_righ{1,12}; % more efficient way?
cbsys_diff = cbsys_prod-cbsys_lost;
% Final number of CBs in the system
cb_end = cbsys_prod(end);
%% Plot number of carbon bonds reaction-wise (broken/produced)
spnames = {'CO' 'CH4' 'CH2OH' 'CH2OOH' 'CH3' 'CH3O' 'CH3O2' 'CH3OH' ...
    'CH3OOH' 'HCO' 'HCHO' 'CH3ONO2'};
step = 'sec';
for in = 1:length(spnames)
    figure;
    plot(cbreac_left{1,in},'b'); hold on; plot(cbreac_righ{1,in},'r'); hold on; plot(cbreac_diff{1,in},'k');
    title(spnames{in}); hold off;
    imgname = strcat(outdir,'/',fname,'_',spnames{in},'.png');
    xlabel(strcat('Time, ',step)); xlim([0 length(RF)]);
    ylabel('number of carbon bonds');
    legend('lost','produced','diff','Location','southeast');
    set(gcf,'visible','off')
%     print(gcf,'-dpng','-r300',imgname);
end
%% Plot changes
figure;
xchange = [-1 86400]; ychange = [cb_init cb_end];
plot(xchange,ychange,'--ok');
imgname = strcat(outdir,'/',fname,'_test.png');
set(gcf,'visible','off')
print(gcf,'-dpng','-r300',imgname);
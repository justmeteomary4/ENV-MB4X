% Read and plot resulting 'fluxes' from ANsCB model
%% Read nett reaction rates (RF % KF : A = B, where RF = KF*A)
clear; clc;
indir = '..';
outdir = 'ANsCB_pics';
out = 'flux_';
fname = '1_01';
fnamelong = [indir,'/',out, fname,'.dat'];
f = importdata(fnamelong,' ',2);
RF = f.data;
for i = 1:numel(f.colheaders)
    header{i} = f.colheaders{i}(2:end); % read headers from 2nd letter
end
RFnames = {'RCH41' 'RCH42' 'RCH43' 'RCH44' 'RCH45' 'RCH46' 'RCH47' 'RCH48' 'RCH49' 'RCH410' 'RCH411' 'RCH412' 'RCH413' 'RCH414' 'RCH415' 'RCH4NO31' 'RCH4NO32' 'RCH4NO33'};
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
ndCH4 = 0;%4.375*10^(13);
ndC2H6 = 0; %2.431*10^(10);
cb_init = 1*ndCO+4*ndCH4+8*ndC2H6;
% % Product (right hand side of reaction)
cbreac_right(1,:) = 1*(RF(:,3)+RF(:,13)+RF(:,14)); % CO
cbreac_right(2,:) = 4*zeros(length(RF),1); % CH4
cbreac_right(3,:) = 2*(RF(:,4)+RF(:,8)+RF(:,9)+RF(:,11)+RF(:,17)); %  HCHO
cbreac_right(4,:) = 3*(RF(:,10)+2*RF(:,12)+RF(:,15)+RF(:,18)); % CH3O
cbreac_right(5,:) = 3*(RF(:,1)+RF(:,5)); % CH3O2
cbreac_right(6,:) = 3*RF(:,11); % CH3OH
cbreac_right(7,:) = 3*RF(:,7); % CH3OOH
cbreac_right(8,:) = 3*RF(:,16); % CH3NO3
% Number of CBs in the system
cbsys_prod = sum(cbreac_right,1); %s um by 1st dimension
% Final number of CBs in the system
cb_end = cbsys_prod(end);
cb_diff = cb_init-cb_end;
%% Plot number of carbon bonds reaction-wise (produced)
spnames = {'CO' 'CH4' 'HCHO' 'CH3O' 'CH3O2' 'CH3OH' 'CH3OOH' 'CH3NO3'};
step = 'sec';
for in = 1:length(spnames)
    figure;
    subplot(1,2,1); plot(cbsys_prod,'b'); title('Total number of CBs');
    subplot(1,2,2); plot(cbsys_prod,'b'); hold on; plot(cbreac_right(in,:),'r'); title(spnames{in}); hold off;
    imgname = strcat(outdir,'/',out,fname,'_',spnames{in},'.png');
    xlabel(strcat('Time, ',step)); xlim([0 length(RF)]);
    ylabel('number of carbon bonds');
    legend('produced','Location','southeast');
    set(gcf,'visible','off')
    print(gcf,'-dpng','-r300',imgname);
end
%% Plot changes
figure;
xchange = [-1 86400]; ychange = [cb_init cb_end];
plot(xchange,ychange,'--ok');
title(strcat(fname, ': number of CBs at t0 (top left) and tN (bottom right)'), 'Interpreter', 'none');
imgname = strcat(outdir,'/',out,'cb_change_',fname,'.png');
set(gcf,'visible','on')
print(gcf,'-dpng','-r300',imgname);
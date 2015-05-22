% Calculate photolysis rate coefficients using parametrisations and formula from
% MCMv3.3
clear; clc;
%% Read MCMv3.3 photolysis parametrisations
indir = 'MCM_photolysis/';
outdir = 'MCM_photolysis/MCM_photolysis_pics/';
name = {'O3(J1)' 'O3(J2)' 'H2O2' 'NO2' 'NO3(J5)' 'NO3(J6)' 'HONO' 'HNO3'...
    'HCHO(J11)' 'HCHO(J12)' 'CH3CHO' 'C2H5CHO' 'C3H7CHO(J15)' 'C3H7CHO(J16)'...
    'IPRCHO' 'MACR(J18)' 'MACR(J19)' 'C5HPALD1' 'CH3COCH3' 'MEK' 'MVK(J23)'...
    'MVK(J24)' 'GLYOX(J31)' 'GLYOX(J32)' 'GLYOX(J33)' 'MGLYOX' 'BIACET' 'CH3OOH'...
    'CH3NO3' 'C2H5NO3' 'NC3H7NO3' 'IC3H7NO3' 'TC4H9NO3' 'NOA'};
fid1 = fopen([indir,'/','MCM_photolysis_coef.dat'],'r');
format1 = '%f %f %f %f %f';
rd1 = textscan(fid1,format1,'headerlines',1);
fclose(fid1);
td1 = cell2mat(rd1);
for n = 1:length(td1)
     pl(n) = td1(n,2).*10^(-td1(n,3));
     pm(n) = td1(n,4);
     pn(n) = td1(n,5);
end
%% Read NOAA solar calculations output
% (sun declination angle, hour angle, solar zenith angle)
lat = 45; lon = -30; tzone = -1; date = '01.07.2015';
fid2 = fopen([indir,'/','NOAA_dec_hour_zenith_angle_min.dat'],'r');
format2 = '%f %f %f';
rd2 = textscan(fid2,format2,'headerlines',1);
fclose(fid2);
td2 = cell2mat(rd2);
for k = 1:length(td2)
    adecl(k) = td2(k,1);
    ahour(k) = td2(k,2);
    azeni(k) = td2(k,3);
    if (azeni(k) >= 90)
        azeni(k) = NaN; % exclude cases when the Sun is below horizon
    end
    % Double-check solar zenith angle
    azeni2(k) = acos(sind(lat)*sind(adecl(k))+cosd(lat)*cosd(adecl(k))*cosd(ahour(k)))*180/pi;
end
%% Calculate photolysis rate coefficients
for i = 1:length(td1) % MCM parameters loop
    for j = 1:length(td2) % solar zenith angle loop
        J1(i,j) = cosd(azeni(j)).*1^(pm(i));
        J2(i,j) = J1(i,j).*pl(i);
        J3(j) = 1./cosd(azeni(j));
        J4(i,j) = exp(-pn(i).*J3(j));
        J5(i,j) = J2(i,j).*J4(i,j);
    end
end
%% Plot photolysis rate coefficient timeseries
for in = 1:length(name)
    figure;
    plot(J5(in,:));
    imgname = strcat(outdir,name{in},'.png');
    title(strcat(name{in},' photolysis rate coefficient'));
    xlabel('Time, min'); xlim([0 length(td2)]);
    ylabel('J, 1/s');
    set(gcf,'visible','off')
    print(gcf,'-dpng','-r300',imgname);
end
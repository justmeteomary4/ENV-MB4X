% Read data on monthly insitu measurements of CH4 dry-air mole fraction at Mauna
% Loa station (1987-2014).
% Calculate overall mean CH4 mole fraction.
clear; clc;
indir = 'MLO/CH4/';
fid = fopen([indir,'/','CH4_montly_1987-2014.dat'],'r');
format = '%s %f %f %f %f %f %s';
rd = textscan(fid,format,'headerLines',71);
fclose(fid);
rd{4}(rd{4}==-999.990) = NaN;
rd{5}(rd{5}==-99.990) = NaN;
% Mean CH4 mixing ratio
CH4mean = nanmean(rd{4});
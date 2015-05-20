% Read data on monthly insitu measurements of CO dry-air mole fraction at Mauna
% Loa station (1987-2014).
% Calculate overall mean CO mole fraction.
clear; clc;
indir = 'MLO/CO/';
fid = fopen([indir,'/','CO_monthly_1989-2013.dat'],'r');
format = '%s %f %f %f';
rd = textscan(fid,format,'headerLines',70);
fclose(fid);
rd{4}(rd{4}==-999.99) = NaN;
% Mean CH4 mixing ratio
COmean = nanmean(rd{4});
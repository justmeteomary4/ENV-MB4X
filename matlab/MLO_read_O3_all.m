% Read 'cleaned' file containing data on hourly insitu measurements of surface O3
% mixing ratios [ppb] at Mauna Loa station from Sept 1973 till Dec 2014.
% Calculate overall mean O3 mixing ratio using precalculated daily mean values.
clear; clc;
indir = 'MLO/';
fid = fopen([indir,'/','O3_clean.dat'],'r');
format = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
rd = textscan(fid,format);
fclose(fid);
td = cell2mat(rd);
td(td == 999.9) = NaN;
% Mean O3 mixing ratio
O3mean = nanmean(td(:,26));
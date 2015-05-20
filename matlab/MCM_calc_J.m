% Calculate photolysis rate using parametrisations and formula from MCMv3.3
clear; clc;
indir = 'MCM_photolysis/';
fid = fopen([indir,'/','MCM_photolysis_coef.dat'],'r');
format = '%f %f %f %f %f';
rd = textscan(fid,format,'headerlines',1);
fclose(fid);
td = cell2mat(rd);
X = 23.12; % solar zenith angle [degrees]
for i = 1:length(td)
     l(i) = td(i,2)*10^(-td(i,3));
     m(i) = td(i,4);
     n(i) = td(i,5);
     J(i) = l(i)*cos(X*pi/180)^m(i)*exp(-n(i)*sec(X*pi/180));
end
plot(J)
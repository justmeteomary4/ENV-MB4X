% Read multiple files containing data on hourly insitu measurements of surface O3
% mixing ratios [ppb] at Mauna Loa station (2011-2015).
% Calculate overall mean O3 mixing ratio (not using precalculated daily mean values).
clear; clc;
indir = 'MLO/O3_2011-2015/';
files = dir(fullfile(indir,'/','lst_mlo_o3_6m_hourlymean_*.dat'));
files = strcat(indir,{files.name}');
format = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
series = cell(numel(files),1);
for i = 1:numel(files)
    fid = fopen(files{i},'r');
    datatemp = textscan(fid,format,'headerLines',7);
    series{i} = datatemp;
    fclose(fid);
end
% Combine all into a matrix
datacell = vertcat(series{:});
datamat = cell2mat(datacell);
datamat(datamat == 999.9) = NaN;
for j = 1:size(datamat,1)
    dmean(j) = nanmean(datamat(j,2:25))';
end
% Mean O3 mixing ratio
O3mean = nanmean(dmean);
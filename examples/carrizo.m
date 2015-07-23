% wavelet analysis of Carrizo Plain DEM
% Robert Sare June 2015

% Import DEM -- Carrizo Plain, 2m resolution
%dem = dem2mat('carrizo.asc');
load('CarrizoDEM.mat');

% Filter DEM at 200m template length
d = 200;
[A, KT, ANG, SNR] = wavelet_filtertile(dem, d);

% Plot raw results
plotscarplet(dem, SNR);
plotscarplet(dem, KT);

% Simple mask by SNR
mask = (SNR.grid >= mean(SNR.grid(:)));
KT.grid = log10(KT.grid);
KT.grid(~mask) = nan;

plotscarplet(dem, KT);

% Save as ESRI ASCII files
mat2dem(SNR, 'carrizo_SNR_200m.asc');
mat2dem(KT, 'carrizo_logkt_200m.asc');

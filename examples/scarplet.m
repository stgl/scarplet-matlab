function [A, KT, ANG, SNR] = scarplet(dem_filename)

%% Applies wavelet filter to a DEM. Returns grids of best-fit parameters.
%%
%% INPUT:   dem_filename - filename of DEM in ESRI ASCII grid format
%% 
%% OUTPUTS: A - best-fit scarp amplitudes (length units)
%%          KT - best-fit scarp morphologic ages (logarithmic scale)
%%          ANG - best-fit scarp orientations (deg from y-axis orientation of grid; if it is UTM, this is N)
%%          SNR - signal-to-noise ratio of best-fit scarp wavelet
%%

[dem, nanidx] = dem2mat(dem_filename);

% Filter DEM at 200m template length
d = 200;
logkt_max = 3.5;
[A, KT, ANG, SNR] = wavelet_filtertile(dem, d, logkt_max);

% Mask out nodata areas
A.grid(nanidx) = A.nodata;
KT.grid(nanidx) = KT.nodata;
ANG.grid(nanidx) = ANG.nodata;
SNR.grid(nanidx) = SNR.nodata;

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

end

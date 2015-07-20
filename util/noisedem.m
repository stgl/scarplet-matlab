function [noisedem, nanidx] = noisedem(dem, sig2 = sqrt(eps))

%% Whitens DEM with Gaussian noise around mean value
%% Robert Sare 2014
%%
%% INPUT:       dem - DEM struct to whiten
%%              sig2 - noise variance
%% OUTPUT:      noisedem - whitened DEM
%%              nanidx - linear indices of NaN values, useful for
%%                       post-processing

tot = sum(nansum(dem.grid));
num = sum(sum(~isnan(dem.grid)));
meanval = tot/num;
noisegrid = randn(dem.ny,dem.nx)*sig2 + meanval;

idx = find(isnan(dem.grid));
dem.grid(idx) = noisegrid(idx);

noisedem = dem;
nanidx = idx;

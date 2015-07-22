function [noisedem, nanidx] = noisedem(dem, sig2, meanval)

%% Whitens DEM with Gaussian noise around mean value
%% Robert Sare 2014
%%
%% INPUT:       dem - DEM struct to whiten
%%              sig2 - noise variance
%%              meanval - noise mean
%% OUTPUT:      noisedem - whitened DEM
%%              nanidx - linear indices of NaN values, useful for
%%                       post-processing

if nargin < 2
    sig2 = sqrt(eps);
end

tot = sum(nansum(dem.grid));
num = sum(sum(~isnan(dem.grid)));
if nargin < 3
    meanval = tot/num;
end

noisegrid = randn(dem.ny,dem.nx)*sig2 + meanval;

idx = find(isnan(dem.grid));
fprintf('DEM contains %i NaNs, (%i %%)', length(idx),
length(idx)/prod(size(dem.grid))*100);
dem.grid(idx) = noisegrid(idx);

noisedem = dem;
nanidx = idx;

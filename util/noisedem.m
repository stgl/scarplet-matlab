function [dem, idx] = noisedem(dem, sig2, meanval)

%% Whitens DEM with Gaussian noise around mean value
%% Robert Sare 2014
%%
%% INPUT:       dem - DEM struct to whiten
%%              sig2 - noise variance
%%              meanval - noise mean
%% OUTPUT:      noisedem - whitened DEM
%%              nanidx - linear indices of NaN values, useful for
%%                       post-processing



idx = find(isnan(dem.grid))';
fprintf('DEM contains %i NaNs, (%3.2f %%)\n', length(idx), length(idx)/prod(size(dem.grid))*100);

if(nargin < 2)
    r = 10;
    for(s=idx)
        [i, j] = ind2sub(size(dem.grid), s);
        ni =  i-r:i+r;
        nj = j-r:j+r;
        ni = ni(ni > 0 & ni <= dem.ny);
        nj = nj(nj > 0 & nj <= dem.nx);
        [NI, NJ] = meshgrid(ni, nj);
        ns = sub2ind(size(dem.grid), NI(:), NJ(:));
        dem.grid(s) = nanmean(dem.grid(ns));
    end
else
    tot = sum(nansum(dem.grid));
    num = sum(sum(~isnan(dem.grid)));
    if nargin < 3
        meanval = tot/num;
    end

    noisegrid = randn(dem.ny,dem.nx)*sig2 + meanval;
    dem.grid(idx) = noisegrid(idx);
end

end

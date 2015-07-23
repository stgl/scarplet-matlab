function [A, KT, ANG, SNR] = wavelet_filtertile(dem, d)

%% Applies wavelet filter to DEM, returning best-fit parameters at each grid
%% point 
%% George Hilley 2010
%% Minor revisions Robert Sare June 2015
%%
%% INPUT:       dem - dem grid struct
%%
%% OUTPUT:      bestA - best-fit scarp amplitudes
%%              bestKT - best-fit morphologic ages
%%              bestANG - best-fit strikes
%%              bestSNR - signal-to-noise ration for best-fit A and error

% Scarp-face fraction, noise level, template length 
frac = 0.9;
sig = 0.1;

if nargin < 2
    d = 200;
end

% Grid search over orientation and ages
l = -2.5:0.1:2.5;
k = 0:0.1:2.5;
[L,K] = meshgrid(l,k);
ANG = (pi./2 - atan2(K,L)) .* 180./pi;
LOGKT = sqrt(L.^2 + K.^2);

de = 2;
M = dem.grid;
bestSNR = zeros(size(M));
bestA = zeros(size(M));
bestKT = zeros(size(M));
bestANG = -9999.*ones(size(M));

% Grid search
for(i=1:length(LOGKT(:,1)))
    for(j=1:length(LOGKT(1,:)))
        thisang = ANG(i,j);
        thiskt = 10.^LOGKT(i,j);
        
        % Compute wavelet parameters for this orientation and morphologic age
        [thisSNR,thisA,thiserr] = calcerror_mat_xcurv(frac,d,thisang,thiskt,de,M);
        k = find(isnan(thisSNR));
        thisSNR(k) = 0;
        
        % Retain parameters with minimum SNR 
        bestA = (bestSNR < thisSNR).*thisA + (bestSNR >= thisSNR).*bestA;
        bestKT = (bestSNR < thisSNR).*thiskt + (bestSNR >= thisSNR).*bestKT;
        bestANG = (bestSNR < thisSNR).*thisang + (bestSNR >= thisSNR).*bestANG;
        bestSNR = (bestSNR < thisSNR).*thisSNR + (bestSNR >= thisSNR).*bestSNR;
       
        % Progress report
        fprintf('%6.2f%%\n',((length(LOGKT(1,:))*(i-1) + j)./(prod(size(LOGKT)))*100));
        
    end
end

A = dem;
KT = dem;
ANG = dem;
SNR = dem;

A.grid = bestA;
KT.grid = bestKT;
ANG.grid = bestANG;
SNR.grid = bestSNR;

end

function [W,M,anx,any] = wavelet_scarp(frac,d,gam,kt,x,y)

%% Returns wavelet template for a step function degrading by simple diffusion
%% George Hilley 2010
%% Minor revisions Robert Sare June 2015
%%
%% INPUT:       frac - limits of scarp profile fit, argument of erfinv
%%              d - out-of-plane dimension of template (m)
%%              gam - strike of template scarp
%%              kt - morphologic age (m^2)
%%              x - vector of x coordinates
%%              y - vector of y coordinates
%%
%% OUTPUT:      W - wavelet template
%%              M - mask for points inside window
%%              anx - horizontal window limit in x direction
%%              any - horizontal window limit in y direction

% Limits of scarp curvature
c = abs(erfinv(frac) .* 2.*sqrt(kt));

% Set up template grid 
[X,Y] = meshgrid(x,y);

alph = -gam.*pi./180;
Xrot = X.*cos(alph)+ Y.*sin(alph);
Yrot = -X.*sin(alph) + Y.*cos(alph);

% Curvature of template scarp
W = -Xrot./(2.*kt.^(3/2).*pi.^(1/2)) .* (exp(-Xrot.^2./(4.*kt)));
M = W;
M(:) = 1;

% Mask template to 0 if we are outside scarp bounds
W = W.*((abs(Xrot) < c) & (abs(Yrot) < d));
M = M.*((abs(Xrot) < c) & (abs(Yrot) < d));

% Template limits, used for clipping
x4 = d.*cos(alph-pi./2);
y4 = d.*sin(alph-pi./2);
x1 = d.*cos(alph);
y1 = d.*sin(alph);
any = abs((x4 - x1) + 2.*c.*cos(alph-pi./2));
anx = abs((y1 - y4) + 2.*c.*sin(alph-pi./2));

end

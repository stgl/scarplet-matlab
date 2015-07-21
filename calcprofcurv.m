function c = calcprofcurv(dem,de,gam)

%% Computes curvature at each point of DEM
%% George Hilley 2010
%% Minor revisions Robert Sare June 2015
%%
%% INPUT:      dem - elevation grid (not grid struct) 
%%              de - dem spacing
%%              gam - template orientation
%%
%% OUTPUT:      c - curvature grid 

% Profile orientation
alph = (gam).*pi./180;

% First- and second-order finite differences
dzdx = diff(dem,1,2)./de;
d2zdxdy = diff(dzdx,1,1)./de;
d2zdxdy = [zeros(length(d2zdxdy(:,1)),1) d2zdxdy];
d2zdxdy = [zeros(1,length(d2zdxdy(1,:)));d2zdxdy];
d2zdx2 = diff(dem,2,2)./de.^2;
d2zdx2 = [zeros(length(d2zdx2(:,1)),1) d2zdx2 zeros(length(d2zdx2(:,1)),1)];
d2zdy2 = diff(dem,2,1)./de.^2;
d2zdy2 = [zeros(1,length(d2zdy2(1,:)));d2zdy2;zeros(1,length(d2zdy2(1,:)))];

%[dzdx,dzdy] = gradient(dem,de);

% Second-order finite difference approximation to DEM curvature
c = d2zdx2.*(cos(alph)).^2 + d2zdy2.*(sin(alph)).^2 - 2.*d2zdxdy.*(sin(alph)*cos(alph));

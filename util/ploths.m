function [x, y, I] = ploths(dem, az, elev, xlims, ylims)

%% ploths(dem, az, elev, xlims, ylims)
%%
%% Plot hillshade of digital elevation model using specified sun azimuth and
%elevation angle
%%
%% INPUTS:
%%  dem     - DEM struct (includes UTM origin, grid resolution(s), matrix of
%elevation)
%%  elev    - sun elevation angle (default 5 deg)
%%  az      - sun azimuth (default 315)
%%  xlims   - vector of x axis limits (optional)
%%  ylims   - vector of y axis limits (optional)
%%

if(nargin < 3)
    elev = 5;
    az = 315;
end
            
% create slope azimuth and magnitude if they aren't precomputed
no_magnitude = ~isfield(dem, 'slopemag');
no_azimuth = ~isfield(dem, 'slopeaz');

if(no_magnitude | no_azimuth)
    dem = computeslopeaz(dem);
end

% compute intensity matrix
az = -az .* pi ./ 180;
elev = elev .* pi ./ 180;

I = cos(elev).*sin(dem.slopemag).*cos(dem.slopeaz-az) + sin(elev).*cos(dem.slopemag);
I = (I + 1)./2 .* 255;

x = (dem.xllcenter+dem.de./2):dem.de:((dem.nx).*dem.de + (dem.xllcenter-dem.de./2));
y = (dem.yllcenter+dem.de./2):dem.de:((dem.ny).*dem.de + (dem.yllcenter-dem.de./2));

colormap gray
imagesc(x,y,I,[27 216]);

I = I./255;

% beautification
a = gca;
set(a,'ydir','normal');
axis equal
axis image
box on

xlabel('Easting (m)')
ylabel('Northing (m)')

if(nargin == 5)
    xlim(xlims);
    ylim(ylims);
end

end

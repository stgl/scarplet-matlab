function [] = plotscarplet(dem, param)

%% Plot hillshade and parameter overlay
%% Robert Sare 2014
%% Adapted from code written to produce figures in Hilley, et al., 2010 GRL
%% paper
%%
%% INPUT:       dem - dem in matlab grid struct
%%              param - grid of parameters

figure
hold on

% Plot hillshade (need slopemag and slopeaz to do this)
I = ploths(dem, 315, 5);

% Plot parameter grid
cmap = jet(254);
cmap = [1 1 1; cmap];
hsv_cmap = rgb2hsv(cmap);

pmin = nanmin(param.grid(:));
pmax = nanmax(param.grid(:));

% Rescale to colormap
colorgrid = (param.grid - pmin)./(pmax - pmin);
idx = param.grid == param.nodata | isnan(param.grid);
colorgrid(idx) = 0;
colorgrid(colorgrid > 1) = 0;

x = (param.xllcenter+param.de./2):param.de:((param.nx).*param.de + (param.xllcenter-param.de./2));
y = (param.yllcenter+param.de./2):param.de:((param.ny).*param.de + (param.yllcenter-param.de./2));

colorimage(:, :, 1) = reshape(hsv_cmap(round(colorgrid.*254)+1, 1), param.ny, param.nx);
colorimage(:, :, 2) = reshape(hsv_cmap(round(colorgrid.*254)+1, 2), param.ny, param.nx);
colorimage(:, :, 3) = I;

colorimage = hsv2rgb(colorimage);

colormap gray
image(x, y, colorimage);

xlabel('Easting');
ylabel('Northing');

a = gca;set(a,'ydir','normal');
axis equal;axis image;

% -----------------------------------------------------------------------------
% Internal functions
function I = ploths(dem,az,elev)

az = -az .* pi ./ 180;
elev = elev .* pi ./ 180;

I = cos(elev).*sin(dem.slopemag).*cos(dem.slopeaz-az) + sin(elev).*cos(dem.slopemag);
I = (I + 1)./2 .* 255;

x = (dem.xllcenter+dem.de./2):dem.de:((dem.nx).*dem.de + (dem.xllcenter-dem.de./2));
y = (dem.yllcenter+dem.de./2):dem.de:((dem.ny).*dem.de + (dem.yllcenter-dem.de./2));

colormap gray
imagesc(x,y,I,[27 216]);

I = I./255;

end

end

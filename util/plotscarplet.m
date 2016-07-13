function [colorimage] = plotscarplet(dem, param, pmax)

%% Plot hillshade and parameter overlay
%% Robert Sare 2014
%% Adapted from code written to produce figures in Hilley, et al., 2010 GRL
%% paper
%%
%% INPUT:       dem - dem in matlab grid struct
%%              param - grid of parameters

hold on

% Plot hillshade (need slopemag and slopeaz to do this)
I = ploths(dem, 315, 5);

% Plot parameter grid

cmap = jet(254);
cmap = [1 1 1; cmap];
hsv_cmap = rgb2hsv(cmap);

pmin = nanmin(param.grid(:));
if(pmax == 0)
    pmax = nanmax(param.grid(:));
end

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
clr = image(x, y, colorimage);
set(clr, 'AlphaData', 0.75)
set(gca, 'FontSize', 18);

xlabel('Easting (m)');
ylabel('Northing (m)');

a = gca;set(a,'ydir','normal');
axis equal;axis image;
lim = xlim;
ticks = linspace(lim(1)+0.25e3, lim(2)-0.25e3, 2);

set(gca, 'XTick', ticks);
box on

end

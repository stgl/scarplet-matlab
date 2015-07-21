% synthetic vertical scarp
% Robert Sare June 2015

function [A, KT, ANG, SNR] = synthetic1()

addpath('../', '../util')

% Create scarp
theta = pi/2;
x = -500:2:500;
y = -500:2:500;

de = 2;
frac = 0.9;
len = 500;
kt = 10^2.5;
b = 0;

[C, U] = calcu_scarp(x, y, len, theta, kt, b, de);

% Populate scarp dem struct
dem = struct('nx', 0, 'ny', 0, 'xllcenter', 0, 'yllcenter', 0, 'de', 0, 'grid', [], 'nodata', NaN);

dem.nx = length(U(1,:));
dem.ny = length(U(:,1));
dem.xllcenter = 0;
dem.yxllcenter = 0;
dem.de = de;
dem.grid = U;

% Filter tile
d = 200;
[A, KT, ANG, SNR] = wavelet_filtertile(dem, d);

% Plot and export results

% -----------------------------------------------------------------------------
% Internal functions
% Generate scarp elevation grid
function [C, U] = calcu_scarp(x, y, d, theta, kt, b, de)

[X, Y] = meshgrid(x, y);

Xrot = X.*cos(theta) + Y.*sin(theta);
Yrot = -X.*sin(theta) + Y.*cos(theta);

idx = find((Xrot < -(d+de/2)) | (Xrot > (d+de/2)));

U = -calcu_1d(Yrot, kt, b);

U = U + 0.1.*randn(length(y), length(x));

C = del2(U, de);

U(idx) = 0;

% Generate scarp profile
function u = calcu_1d(x, kt, b)

u = erf(x./(2*sqrt(kt))) + b.*x;

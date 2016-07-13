function grid = computeslopeaz(grid)

slopex = (grid.grid(:,3:end) - grid.grid(:,1:end-2))./(2.*grid.de);
slopex = [slopex(:,1) slopex slopex(:,end)];

slopey = (grid.grid(3:end,:) - grid.grid(1:end-2,:))./(2.*grid.de);
slopey = [slopey(1,:);slopey;slopey(end,:)];

grid.slopemag = sqrt(slopex.^2 + slopey.^2);
grid.slopeaz = pi./2 - atan2(slopey,slopex);


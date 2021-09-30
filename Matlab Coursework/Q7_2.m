close all;
clear all;

% A 2D polygon: square of 2 by 2 units.
p = [-1 1 1 -1 -1 ; -1 -1 1 1 -1];


% Points in p are to be in homogeneous coordinates.
p(3,:) = 1;
pp=p.';

% Set up axes for plotting our animation.
figure;
hold on;
axis equal;

% The square should rotate about this point.
x1=3;
x2=4;
point = [x1, x2];

for theta = 0:0.1:2 * pi

    % Set up matrix R to be a rotation transformation
    % (anticlockwise about origin by angle theta).
    R = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
    RR=R.';
    %translate centre of rotation to origin
    T = [1 0 -x1; 0 1 -x2; 0 0 1];
    Y=T.';
    
    %transfer centre of rotation back
    TT=[1 0 x1; 0 1 x2; 0 0 1];
    YY=TT.';
    
    % Perform the transform R.
    pprime = pp*RR*YY;
    %pprime = R * p;
    
    % Divide by homogeneous coordinate.
    pprime(:,1) = pprime(:,1) ./ pprime(:,3);
    pprime(:,2) = pprime(:,2) ./ pprime(:,3);
    
    % Plot polygon in pprime in blue, point in red.
    cla; % clear axes
    plot(pprime(:,1), pprime(:,2), 'b', 'LineWidth', 3);
    plot(point(1), point(2), 'r.', 'MarkerSize', 20);
    axis([-12 12 -12 12]);
    drawnow;
    
end
close all;
clear all;

% Read in two photos of the library.
left  = im2double(imread('parade1.bmp'));
right = im2double(imread('parade2.bmp'));

% Draw the left image.
figure(1);
image(left);
axis equal;
axis off;
title('Left image');
hold on;

% Draw the right image.
figure(2);
image(right);
axis equal;
axis off;
title('Right image');
hold on;

% Get 4 points on the left image.
figure(1);
[x, y] = ginput(4);
leftpts = [x'; y'];
% Plot left points on the left image.
figure(1)
plot(leftpts(1,:), leftpts(2,:), 'rx');

% Get 4 points on the right image.
figure(2);
[x, y] = ginput(4);
rightpts = [x'; y'];
% Plot the right points on the right image
figure(2)
plot(rightpts(1,:), rightpts(2,:), 'gx');

% compute the homography between the left and right points.

a = calchomography(leftpts,rightpts);

% have user click on left image, and plot their click. Then estimate
% point in right image using the homography and draw that point.
while true 
    figure(1);
    [x, y] = ginput(1);
    point = [x ; y ;1];

    r = a * point;
    r(1) = r(1)/r(3);
    r(2) = r(2)/r(3);
    
    figure(1);
    plot(point(1), point(2), 'rx');
    figure(2);
    plot(r(1), r(2), 'gx');
end





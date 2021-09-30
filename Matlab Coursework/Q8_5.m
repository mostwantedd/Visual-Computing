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

%% compute the homography between the left and right points.
a = calchomography(leftpts,rightpts);
%%

source = im2double(imread('parade1.bmp'));
target = im2double(imread('parade2.bmp'));
% The forward mapping loop: iterate over every source pixel.
for y = 1:size(target, 1)
    for x = 1:size(target, 2)

        % Transform source pixel location (round to pixel grid).
        p = [x; y; 1];
        q = inv(a) * p;
        u = round(q(1) / q(3));
        v = round(q(2) / q(3));

        % Check if target pixel falls inside the image domain.
        if (u > 0 && v > 0 && u <= size(source, 2) && v <= size(source, 1))
            % Sample the target pixel colour from the source pixel.
            target(y, x, :) = source(v, u, :);
        end

    end
end
figure;
imshow([source target]);

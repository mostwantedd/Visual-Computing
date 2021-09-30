clear all;
close all;

source = im2double(imread('mona.jpg'));
target = zeros(size(source));

T = [1 0 -size(source, 2) / 2; 0 1 -size(source, 1) / 2; 0 0 1];
t = pi / 4;
R = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
S = [4 0 0; 0 4 0; 0 0 1];

% The warping transformation (rotation + scale about an arbitrary point).
M = inv(T) * R * S * T;

% The forward mapping loop: iterate over every source pixel.
for y = 1:size(target, 1)
    for x = 1:size(target, 2)

        % Transform source pixel location (round to pixel grid).
        p = [x; y; 1];
        q = inv(M) * p;
        u1 = floor(q(1)/q(3));
        u2 = ceil(q(1)/q(3));
        v1 = floor(q(2)/q(3));
        v2 = ceil(q(2)/q(3));
        
         if (u1 > 0 && u1 <= size(target, 2)) && ...
            (u2 > 0 && u2 <= size(target, 2)) && ...
            (v1 > 0 && v1 <= size(target, 1)) && ...
            (v2 > 0 && v2 <= size(target, 1))
                 
            f1 = source(v1,u1,:);
            f2 = source(v1,u2,:);
            f3 = source(v2,u1,:);
            f4 = source(v2,u2,:);

            a = q(1)-u1;
            b = q(2)-v1;

            f12 = (1 - a) * f1 + a * f2;
            f34 = (1 - a) * f3 + a * f4;
            f1234 = (1 - b) * f12 + b * f34;
        
            % Sample the target pixel colour from the source pixel.
            target(y, x, :) = f1234;
         end
    end

end

imshow([source target]);

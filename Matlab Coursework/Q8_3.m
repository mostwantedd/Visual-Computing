clear all;
close all;

source = im2double(imread('window.jpg'));
target = zeros(size(source));

fx = 474.53;
px = 405.96;
fy = 474.53;
py = 217.81;
k1 = -0.27194;
k2 = 0.11517;
k3 = -0.029859;


% The forward mapping loop: iterate over every source pixel.
for v = 1:size(target, 1)
    for u = 1:size(target, 2)

        x = (u - px)/fx;
        y = (v - py)/fy;
        r2 = x^2 + y^2;
        m =1 + k1 * r2 + k2 * r2^2 + k3 * r2^3;
        x1 = x * m;
        y1 = y * m;
        uu = x1 * fx + px;
        vv = y1 * fy + py;
        
        u1 = floor(uu);
        u2 = ceil(uu);
        v1 = floor(vv);
        v2 = ceil(vv);
        
         if (u1 > 0 && u1 <= size(target, 2)) && ...
            (u2 > 0 && u2 <= size(target, 2)) && ...
            (v1 > 0 && v1 <= size(target, 1)) && ...
            (v2 > 0 && v2 <= size(target, 1))
                  
            f1 = source(v1,u1,:);
            f2 = source(v1,u2,:);
            f3 = source(v2,u1,:);
            f4 = source(v2,u2,:);

            a = uu-u1;
            b = vv-v1;

            f12 = (1 - a) * f1 + a * f2;
            f34 = (1 - a) * f3 + a * f4;
            f1234 = (1 - b) * f12 + b * f34;
        
            % Sample the target pixel colour from the source pixel.
            target(v, u, :) = f1234;
         end
    end

end

imshow([source target]);

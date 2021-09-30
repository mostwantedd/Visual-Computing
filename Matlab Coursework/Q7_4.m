%% Transforms Lab
%
% Task: edit the transforms in this cell to align the outlined shapes
%       with the dotted outlines of the same colour hue.

% (a) Translation.
T_a = [1 0 5; 0 1 1; 0 0 1];

% (b) Isotropic scale + translation.
TT_b = [1 0 7; 0 1 0; 0 0 1];
I_b = [0.4 0 0; 0 0.4 0; 0 0 1];
T_b = TT_b * I_b;

% (c) Anisotropic scale + translation.
TT_c = [1 0 9.5; 0 1 1.5; 0 0 1];
A_c = [1.2 0 0; 
       0 0.4 0; 
       0 0 1];
T_c = TT_c * A_c;

% (d) Rotation + translation.
t = pi/4;
TT_d = [1 0 0; 0 1 7; 0 0 1];
R_d = [cos(t) sin(t) 0; -sin(t) cos(t) 0; 0 0 1];
T_d = TT_d * R_d;

% (e) Isotropic scale + rotation + translation.
s = pi/-4;
TT_e = [1 0 2; 0 1 10; 0 0 1];
R_e = [cos(s) sin(s) 0; -sin(s) cos(s) 0; 0 0 1];
I_e = [0.5 0 0; 0 0.5 0; 0 0 1];
T_e = TT_e * I_e * R_e;

% (f) Anisotropic scale + rotation + translation.
q = pi/1.333;
TT_f = [1 0 4; 0 1 14; 0 0 1];
R_f = [cos(q) sin(q) 0; -sin(q) cos(q) 0; 0 0 1];
I_f = [0.4 0 0; 0 0.8 0; 0 0 1];
T_f = TT_f * R_f * I_f;

% (g) Fully affine.
leftpts = [0,0,4,3;0,5,5,2];
rightpts = [7.975, 9.975, 13.57, 11.47; 8.025, 12.53, 14.13, 11.03];
T_g = calchomography(leftpts, rightpts);



% (h) Perspective.
leftpts = [0,0,4,3;0,5,5,2];
rightpts = [9.812, 10.2, 14.19, 11.74; 5.649, 8.393, 7.8, 5.955];
T_h = calchomography(leftpts, rightpts);




%% Apply transformations and draw the results -- DO NOT EDIT BELOW LINE.

% Start shape: a 2D pologyon in the shape of an 'F'.
p = [0 0 4 4 1 1 3 3 1 1 0; 0 5 5 4 4 3 3 2 2 0 0; 1 1 1 1 1 1 1 1 1 1 1];

% Apply the defined transforms to the input shape.
p_a = T_a * p;
p_b = T_b * p;
p_c = T_c * p;
p_d = T_d * p;
p_e = T_e * p;
p_f = T_f * p;
p_g = T_g * p;
p_h = T_h * p;

% Set up axes.
figure;
hold on;
axis equal;
axis([-1 15 -1 15]);

% Draw the transformed shapes.
plot(p_a(1,:) ./ p_a(3,:), p_a(2,:) ./ p_a(3,:), 'Color', [0.6 0   0  ], 'LineWidth', 3);
plot(p_b(1,:) ./ p_b(3,:), p_b(2,:) ./ p_b(3,:), 'Color', [0   0.6 0  ], 'LineWidth', 3);
plot(p_c(1,:) ./ p_c(3,:), p_c(2,:) ./ p_c(3,:), 'Color', [0   0   0.6], 'LineWidth', 3);
plot(p_d(1,:) ./ p_d(3,:), p_d(2,:) ./ p_d(3,:), 'Color', [0   0.6 0.6], 'LineWidth', 3);
plot(p_e(1,:) ./ p_e(3,:), p_e(2,:) ./ p_e(3,:), 'Color', [0.6 0   0.6], 'LineWidth', 3);
plot(p_f(1,:) ./ p_f(3,:), p_f(2,:) ./ p_f(3,:), 'Color', [0.6 0.6 0  ], 'LineWidth', 3);
plot(p_g(1,:) ./ p_g(3,:), p_g(2,:) ./ p_g(3,:), 'Color', [0.6 0.3 0  ], 'LineWidth', 3);
plot(p_h(1,:) ./ p_h(3,:), p_h(2,:) ./ p_h(3,:), 'Color', [0.3 0   0.6], 'LineWidth', 3);

% Initial shape and location.
text(0, -0.5, 'start shape'); plot(p(1,:), p(2,:), 'k', 'LineWidth', 3);

% Target shapes.
text( 5.3,  1.5, 'a'); plot([5 5 9 9 6 6 8 8 6 6 5], [1 6 6 5 5 4 4 3 3 1 1], ':', 'Color', [1 0.6 0.6], 'LineWidth', 1);
text( 7.7,  0.3, 'b'); plot([7 7 8.6 8.6 7.4 7.4 8.2 8.2 7.4 7.4 7], [0 2 2 1.6 1.6 1.2 1.2 0.8 0.8 0 0], ':', 'Color', [0.6 1 0.6], 'LineWidth', 1);
text(10,    2,   'c'); plot([9.5 9.5 14.3 14.3 10.7 10.7 13.1 13.1 10.7 10.7 9.5], [1.5 3.5 3.5 3.1 3.1 2.7 2.7 2.3 2.3 1.5 1.5], ':', 'Color', [0.6 0.6 1], 'LineWidth', 1);
text( 0.5,  7,   'd'); plot([0 3.53553390593274 6.36396103067893 5.65685424949238 3.53553390593274 2.82842712474619 4.24264068711929 3.53553390593274 2.12132034355964 0.707106781186548 0], [7 10.5355339059327 7.70710678118655 7 9.12132034355964 8.4142135623731 7 6.29289321881345 7.70710678118655 6.29289321881345 7], ':', 'Color', [0.6 1 1], 'LineWidth', 1);
text( 0.5, 10.5, 'e'); plot([2 0.232233047033631 1.64644660940673 2 0.939339828220179 1.29289321881345 2 2.35355339059327 1.64644660940673 2.35355339059327 2], [10 11.7677669529664 13.1819805153395 12.8284271247462 11.7677669529664 11.4142135623731 12.1213203435596 11.7677669529664 11.0606601717798 10.3535533905933 10], ':', 'Color', [1 0.6 1], 'LineWidth', 1);
text( 3.8, 12.5, 'f'); plot([4 6.82842712474619 5.69705627484771 5.13137084989848 5.97989898732233 5.41421356237309 4.84852813742386 4.28284271247462 4.84852813742386 3.71715728752538 4], [14 11.1715728752538 10.0402020253553 10.6058874503046 11.4544155877284 12.0201010126777 11.4544155877284 12.0201010126777 12.5857864376269 13.7171572875254 14], ':', 'Color', [0.6 1 0.6], 'LineWidth', 1);
text( 7.8,  9.5, 'g'); plot([7.97487373415292 9.97487373415292 13.5748737341529 13.1748737341529 10.4748737341529 10.0748737341529 11.8748737341529 11.4748737341529 9.67487373415292 8.87487373415292 7.97487373415292], [8.02512626584708 12.5251262658471 14.1251262658471 13.2251262658471 12.0251262658471 11.1251262658471 11.9251262658471 11.0251262658471 10.2251262658471 8.42512626584708 8.02512626584708], ':', 'Color', [1 0.8 0.6], 'LineWidth', 1);
text(10.8,  5.5, 'h'); plot([9.812 10.1963302752294 14.1855010660981 13.4 10.8298217179903 10.6398305084746 12.0611940298507 11.7371879106439 10.4931163954944 10.2813455657492 9.812], [5.649 8.39266055045871 7.79957356076759 6.91607142857143 7.39059967585089 6.74435028248588 6.44328358208955 5.95532194480946 6.24530663329161 5.5249745158002 5.649], ':', 'Color', [0.8 0.6 1], 'LineWidth', 1);

%% 

function H = calchomography(points1, points2)

    if size(points1, 2) < 4 || size(points2, 2) < 4
        error('Need at least 4 points for a homography.');
    end

    A = [];

    for point = 1:size(points1, 2)
      x = points1(1, point);
      y = points1(2, point);
      u = points2(1, point);
      v = points2(2, point);

      A = [A; ...
           -x   -y   -1    0    0    0   x * u   y * u   u; ...
            0    0    0   -x   -y   -1   x * v   y * v   v];

    end

    % Solve A * h = 0 for h.
    [U, S, V] = svd(A);
    h = V(:,end);

    % Reshape vectorised result back into matrix shape.
    H = reshape(h, 3, 3)';

    % Homogeneous normalisation.
    H = H ./ H(3,3);
end




close all;
clear all;

% 2D polygon for Earth: square of 2 by 2 units, in homogeneous coordinates.
earth = [-1 1 1 -1 -1; -1 -1 1 1 -1; 1 1 1 1 1];

% Another 2D polygon for the Moon, made by scaling the earth to 1/4 size
S = [0.25 0 0; 0 0.25 0; 0 0 1];
S3 = [0.1 0 0; 0 0.1 0; 0 0 1];
S2 = [0.3 0 0; 0 0.3 0; 0 0 1];
moon = S * earth;
moon2 = S2 * earth;
moon3 = S3 * earth;


% Set up axes for plotting our animation.
fig = figure;
hold on;
axis equal;
axis([-8 8 -8 8]);


for a = 0:0.01:2 * pi 
    if ishghandle(fig) == false
        return
    end

	% Moon will spin 5 times as fast as the Earth.
	a_moon = 5 * a;
    a_moon2 = 10 *a;
    a_moon3 = 2 *a;


	% Rotation matrix for Earth.
	R_earth = [cos(a) -sin(a) 0; sin(a) cos(a) 0; 0 0 1];

	% Rotation matrix for the Moon.
	R_moon = [cos(a_moon) -sin(a_moon) 0; sin(a_moon) cos(a_moon) 0; 0 0 1];
    R_moon2 = [cos(a_moon2) -sin(a_moon2) 0; sin(a_moon2) cos(a_moon2) 0; 0 0 1];
    R_moon3 = [cos(a_moon3) -sin(a_moon3) 0; sin(a_moon3) cos(a_moon3) 0; 0 0 1];

	% Translation matrix to move the Moon away from Earth
    % (it orbits at a distance of 5 units).
	T_moon = [1 0 5; 0 1 0; 0 0 1];
    T_moon2 = [1 0 3; 0 1 0; 0 0 1];
    T_moon3 = [1 0 1; 0 1 0; 0 0 1];
    
	% Rotate the Earth.
	p_earth = R_earth * earth;

	% Rotate the moon, then move it 5 units away from the origin.
	p_moon = T_moon * R_moon * moon;
    p_moon2 =  T_moon2 * R_moon2 * moon2;
    p_moon3 = T_moon3 * R_moon3 * moon3;
    p_moon3 = T_moon2 * R_moon2 * p_moon3;

	% Place the moon in the Earth's reference frame (which is R).
	p_moon = R_earth * p_moon;
    p_moon2 = R_earth * p_moon2;
    p_moon3 = R_earth * p_moon3 ;
    
	% Draw the earth in blue and the moon in black.
	cla;
	plot(p_earth(1,:), p_earth(2,:), 'b', 'LineWidth', 2);
	plot(p_moon(1,:),  p_moon(2,:),  'k', 'LineWidth', 2);
    plot(p_moon2(1,:),  p_moon2(2,:),  'g', 'LineWidth', 2);
    plot(p_moon3(1,:),  p_moon3(2,:),  'y', 'LineWidth', 2);
    
    
	drawnow;

end


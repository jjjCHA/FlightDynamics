function [x_trim,u_trim] = compute_trim(filename, Va, gamma, R)
% Va is the desired airspeed (m/s)
% gamma is the desired flight path angle (radians)
% R is the desired radius (m) - use (+) for right handed orbit, 
%                                   (-) for left handed orbit


% add stuff here
e = euler2quat(0,gamma,0);
x0 = [0;0;0; Va;0;0; e'; 0;0;0];
ix0 = [];
u0 = [0;0;0;1];
iu0 = [];
y0 = [Va; gamma; 0];
iy0 = [1,3];
edot = euler2quat(0,0,Va/R*cos(gamma));
dx0 = [0;0;-Va*sin(gamma); 0;0;0; edot'; 0;0;0];
idx = [3:13];

% x0 = [0;0;0; Va;0;0; 0;gamma;0; 0;0;0];
% dx0 = [0;0;-Va*sin(gamma); 0;0;0; 0;0;Va/R; 0;0;0];
% idx = [3:12];

% compute trim conditions
[x_trim,u_trim,y_trim,dx_trim] = trim(filename,x0,u0,y0,ix0,iu0,iy0,dx0,idx);

% check to make sure that the linearization worked (should be small)
norm(dx_trim(3:end)-dx0(3:end))


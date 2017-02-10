function [A_lon,B_lon,A_lat,B_lat] = compute_ss_model(filename,x_trim,u_trim)
% x_trim is the trimmed state,
% u_trim is the trimmed input
  
pn    = x_trim(1);
pe    = x_trim(2);
pd    = x_trim(3);
u     = x_trim(4);
v     = x_trim(5);
w     = x_trim(6);
e     = x_trim(7:10);
p     = x_trim(11);
q     = x_trim(12);
r     = x_trim(13);
delta_e = u_trim(1);
delta_a = u_trim(2);
delta_r = u_trim(3);
delta_t = u_trim(4);

Va = sqrt(u^2+v^2+w^2);
beta = atan2(v,sqrt(u^2+w^2));

% Extract out some variables
rho = P.rho;
S = P.S_wing;
b = P.b;

Y_v = rho*S*b*v/(4*m*Va)*(P.C_Y_p*p + P.C_Y_r*r) + rho*S*v/P.mass*(P.C_Y_0 + P.C_Y_beta*beta + P.C_Y_delta_a*delta_a + P.C_Y_delta_r*delta_r) + rho*S*P.C_Y_beta/(2*P.mass)*sqrt(u^2+w^2);
Y_p = w + rho*Va*S*b/(4*P.mass)*P.C_Y_p;
Y_r = -u + rho*Va*S*b/(4*P.mass)*P.C_Y_r;
Y_delta_a = rho*Va^2*S/(2*P.mass)*P.C_Y_delta_a;
Y_delta_r = rho*Va^2*S/(2*P.mass)*P.C_Y_delta_r;
L_v = rho*S*b^2*v/(4*Va)*(P.C_p_p*p + P.C_p_r*r) + rho*S*b*v*(P.C_p_0 + P.C_p_beta*beta + P.C_p_delta_a*delta_a + P.C_p_delta_r*delta_r) + rho*S*b*P.C_p_beta/2*sqrt(u^2+w*2);
L_p =  P.G(1)*q + rho*Va*S*b^2/4*P.C_p_p;
L_r = -P.G(2)*q + rho*Va*S*b^2/4*P.C_p_r;
L_delta_a = rho*Va^2*S*b/2*P.C_p_delta_a;
L_delta_r = rho*Va^2*S*b/2*P.C_p_delta_r;
N_v = rho*S*b^2*v/(4*Va)*(P.C_r_p*p + P.C_r_r*r) + rho*S*b*v*(P.C_r_0 + P.C_r_beta*beta + P.C_r_delta_a*delta_a + P.C_r_delta_r*delta_r);
N_p =  P.G(7)*q + rho*Va*S*b^2/4*P.C_r_p;
N_p = -P.G(1)*q + rho*Va*S*b^2/4*P.C_r_r;
N_delta_a = rho*Va^2*S*b/2*P.C_r_delta_a;
N_delta_r = rho*Va^2*S*b/2*P.C_r_delta_r;

A_lat = [Y_v Y_p Y_r                 P.g*cos(theta)*cos(phi)                     0;...
         L_v L_p L_r                 0                                           0;...
         N_v N_p N_r                 0                                           0;...
         0   1   cos(phi)*tan(theta) q*cos(phi)*tan(theta)-r*sin(phi)*tan(theta) 0;...
         0   0   cos(phi)*sec(theta) p*cos(phi)*sec(theta)-r*sin(phi)*sec(theta) 0];

B_lat = [Y_delta_a Y_delta_r;...
         L_delta_a L_delta_r;...
         N_delta_a N_delta_r;...
         0         0;...
         0         0];
     
 X_u = u*rho*S/P.mass*(P.C_X
     

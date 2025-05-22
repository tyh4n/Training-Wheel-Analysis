%% Init
clear;

max_tilt = 18;      % [degree] 
max_wid = 10;       % [in]

I_ball = 0.052;     % Ball inertia [kgm^2]
m_ball = 4.0;       % Ball mass[kg]
I_body = 3.0;       % Body inertia [kgm^2]
m_body = 92;        % Body mass [kg] 
r_ball = 0.114;     % Ball radius [m]
l = 0.45;           % Body length (IP) [m]
g = 9.81;           % gravity const [m/s^2]

r_leg = linspace(100, 200, 100) * 10^-3;     % Ring radius [m] 
h_leg = linspace(0, 50, 100) * 10^-3;        % Leg distance from ground [m]

%% Calculation
[R_leg, H_leg] = meshgrid(r_leg, h_leg);

l_tilt = sqrt((l + r_ball - H_leg).^2 + R_leg.^2);
l_tilt(l_tilt < (r_ball + l)) = r_ball + l;

v = sqrt(2 * g * (l_tilt - (l + r_ball)));

surf(R_leg * 10^3, H_leg * 10^3, v);
shading interp;
xlabel('r_{leg} [mm]');
ylabel('h_{leg} [mm]');
zlabel('v_{init} [m/s]');
zlim([0.01, 1.5]);
colorbar;
view(215, 30)
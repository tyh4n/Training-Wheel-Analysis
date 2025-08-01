% Created by Tianyi Han, Nov.26 2024

%% Contact Model
k_gy = 80000;           % vertical ground interaction stiffness [N/m]
v_gy_max = 0.03;        % maximum vertical ground relaxation speed [m/s]
k_gx = 8000;            % horizontal ground interaction stiffness [N/m]
v_gx_max = 0.03;        % maximum horizontal ground relaxation speed [m/s]
mu_stick = 0.9;         % stiction coefficient
mu_slide = 0.8;         % sliding coefficient
vLimit = 0.01;          % slip-stic transition velocity [m/s]

leg_mu_stick = 1.0;     % leg-ground stiction coefficient
leg_mu_slide = 0.9;    % leg-ground sliding coefficient

hip_mu_stick = 0.6;     % hip-seat stiction coefficient
hip_mu_slide = 0.5;    % hip_seat sliding coefficient

%% Ballbot Config
i_ball = 0.052;         % Ball inertia [kgm^2]
m_ball = 4.0;           % Ball mass[kg]
i_body_xy = 0.441;      % Body inertia about x,y axis [kgm^2]
i_body_z = 0.2025;      % Body inertia about z axis [kgm^2]
m_body = 30.1;          % Body mass [kg] 
r_ball = 0.114;         % Ball radius [m]
l = 0.368/2;            % Body length (IP) [m]

r_ring = 0.307;         % Ring radius [m] 
% The radius of the ring is set to 0.307, such that when the leg is 0.05m
% from ground. Legs will contact with ground at 10 degree tilt.
h_ring = 0.114;         % Ring distance from ground [m]
h_leg = 0.06;           % Leg distance from ground [m]

leg_mode = 0;           % Leg prismatic joint mode, 0: normal, 1: locked, -1: disengaged

%% Inverted Spring-Damper Pendulum Model
h_thigh = 0.162;        % Thigh "block" height [m]
m_thigh = 14.1;         % Thigh mass [kg]
i_thigh_xy = 0.0782;    % Thigh inertia about x,y axis [kgm^2]
i_thigh_z = 0.0948;     % Thigh inertia about z axis [kgm^2]

h_upper = 0.169*2;      % Upper body height (2x pendulum height) [m]
m_upper = 47.8;         % Upper body mass [kg]
i_upper_xy = 0.6159;    % Upper body inertia about x,y axis [kgm^2]
i_upper_z = 0.3218;     % Upper body inertia about z axis [kgm^2]

hip_stiffness = 547.4;  % Hip joint spring stiffness [Nm/rad]
hip_damping = 20.3;     % Hip joint damper ratio [Nm/rad]

seat_depth = 0.4;       % Seat depth [m]

%% PID Control Parameters
k_p = 5000;
k_i = 200;
k_d = 500;

%% Leg Spring Damper Parameters
k_leg = 2000;           % Leg spring stiffness [N/m]
b_leg = 100;            % Leg damping coefficient [N/(m/s)]

%% Load Trajectory
% load('data/traj_1.mat', 'traj_sol', 'time');
t_interval = 10;        % Simulation time resolution [ms]
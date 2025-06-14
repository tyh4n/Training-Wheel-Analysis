%% Contact Model
k_gy = 80000;       % vertical ground interaction stiffness [N/m]
v_gy_max = 0.03;    % maximum vertical ground relaxation speed [m/s]
k_gx = 8000;        % horizontal ground interaction stiffness [N/m]
v_gx_max = 0.03;    % maximum horizontal ground relaxation speed [m/s]
mu_stick = 0.9;     % stiction coefficient
mu_slide = 0.8;     % sliding coefficient
vLimit = 0.01;      % slip-stic transition velocity [m/s]

k_contact = 80000;       % contact interaction stiffness [N/m]
v_c_max = 0.03;          % maximum contact relaxation speed [m/s]

%% Wheel parameters
w_wheel = 1;        % wheel width [m]
r_wheel = 0.5;      % wheel radius [m]
E = 120e3;        % Wheel elastic modulus [Mpa]
% miu_x = 0.75;       % Logitutional coefficient of friction 
k_x = 2700e3;       % Logitutional stiffness [N/m^2]
miu_s = 0.75;       % Sliding coefficient of friction
miu_p = 1;          % Peak coefficient of friciton
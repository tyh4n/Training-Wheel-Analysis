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

%%
r_wheel = 0.5;
E = 6000000; 
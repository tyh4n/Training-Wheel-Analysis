%% Init
max_tilt = 18;      % [degree] 
min_wid = 0.3;      % [m]
max_wid = 0.5;      % [m]

r = 0.114;     % Ball radius [m]
c_leg = 0.05;  % Leg clearance [m]

m_ball = 4.0;       % Ball mass[kg]
m_body = 92;        % Body mass [kg] 
g = 9.81;           % Gravity const [m/s^2]
Fz = (m_body + m_ball) * g; % [N]

nu = 0.4;           % Poisson's ratio
h = 0.0125;         % Ball coat thickness [m]
E = 2.7e6;          % Ball coat Young's modulus

%% 
r_contact = ( (4 * Fz * (1 - nu^2) * r * h) / (pi * E) )^0.25;
h_loss = r - sqrt(r^2 - r_contact^2);

r_leg = linspace(0.5 * min_wid, 0.5 * max_wid); % Distance to center

phi_appr = atand(c_leg ./ r_leg);
phi = asind(r ./ sqrt(r_leg.^2 + (r - c_leg)^2)) - atand((r - c_leg) ./ r_leg);

length_e = r * sind(phi);
contact_idx = find(length_e < r_contact);
phi(contact_idx) = atand((c_leg - h_loss) ./ (r_leg(contact_idx) - r_contact));

err = (phi - phi_appr) ./ phi * 1e2;

disp('Percentage bigger contact area:');
disp(length(k)/length(e));

figure(1);
hold on;
yyaxis left
plot(r_leg * 1e3, phi);
plot(r_leg * 1e3, phi_appr);
ylabel('\phi_{max} [degree]');

yyaxis right
plot(r_leg * 1e3, err);
ylabel('Error [%]');

xline(r_leg(contact_idx(1)) * 1e3, '--', {'Contact dominant','r_{contact} > e'});

xlabel('r_{leg} [mm]');
legend('\phi_{max}', '\phi_{max} approx', 'Error', location='southwest');
fontsize(14,"points")
%% Init 
r_ring_arr = linspace(0.25, 0.4, 10);     % Array of ring radii to test [m]
h_leg_arr = linspace(0.05, 0.10, 10);     % Array of leg heights to test [m]
v_crit = zeros(length(h_leg_arr), length(r_ring_arr)); % Initialize matrix to store critical velocities

%% Binary Splitting Evaluation
for r_idx = 1 : length(r_ring_arr)                     % Loop over ring radii
    for h_idx = 1 : length(h_leg_arr)                  % Loop over leg heights
        % Display current setup index and progress percentage
        disp('Setup # ');
        disp((r_idx - 1) * length(h_leg_arr) + h_idx);
        disp('Percentage: ');
        disp(((r_idx - 1) * length(h_leg_arr) + h_idx) / ...
            (length(h_leg_arr) * length(r_ring_arr)) * 100);
        
        % Get current parameters
        r_ring = r_ring_arr(r_idx);
        h_leg = h_leg_arr(h_idx);
        
        % Initialize binary search range for accel_time
        accel_time_l = 2;           % Lower bound of acceleration time
        accel_time_r = 6;           % Upper bound of acceleration time
        accel_time_m = (accel_time_l + accel_time_r) / 2;  % Mid value
        
        % Perform binary search until time difference is within 0.2 seconds
        while (accel_time_r - accel_time_l) > 0.2
            accel_time = accel_time_m;
            
            % Run simulation (ballbot_isp model) with StopTime 10 seconds
            sim_out = sim('ballbot_isp', 'StopTime', '10');    
            
            tout = sim_out.get('tout');  % Get simulation time vector
            
            % Check if simulation completed successfully
            if tout(end) < 10
                disp('Simulation was interrupted!');
                accel_time_r = accel_time_m;   % Reduce upper bound
            else
                disp('Simulation completed normally.');
                accel_time_l = accel_time_m;   % Increase lower bound
            end
            
            % Update mid value for next iteration
            accel_time_m = (accel_time_l + accel_time_r) / 2;
        end
        
        % Find velocity at t ≈ 7 seconds in the simulation output
        idx = find(abs(sim_out.v_body.time - 7) < 0.001);
        v_crit(h_idx, r_idx) = sim_out.v_body.data(idx(1));  % Store critical velocity
    end
end

%% Save data
save("data/isp_2s6s_025040510_miu1_6x6.mat", "r_ring_arr", "h_leg_arr", "v_crit"); % Save results to .mat file

%% Plot
figure('Position', [100 100 900 600]);
% Create a 1x2 grid: subplot(1,2,1) is main plot; subplot(1,2,2) is colorbar
ax1 = subplot(1,16,1:14);   % wide left plot (9/10)
axes(ax1);  % make sure we're plotting on left subplot

[X,Y] = meshgrid(r_ring_arr, h_leg_arr);  % Create grid for contour plot

% surf(X, Y, v_crit);
colormap(winter);
[C,h] = contour(X,Y,v_crit);              % Create contour plot of critical velocities
clabel(C,h, 'FontSize', 16, 'Color', 'k'); % Label contour lines with black text, font size 16

xlabel("r_{leg} [m]");                     % X-axis label
ylabel("h_{leg} [m]");                     % Y-axis label
zlabel("v_{critical} [m/s]");              % Z-axis label (not shown unless 3D)

% view(-45,45);                            % Optional: set 3D view
% shading interp;                          % Optional: smooth shading
% colorbar;                                % Optional: add colorbar

fontsize(16,"points");                     % Set global font size to 16 points
xlim([0.25, 0.4]);                         % Set X-axis limits
ylim([0.05, 0.1]);                          % Set Y-axis limits
zlim([0, 4]);                               % Set Z-axis limits (effective only for 3D plots)

%% Phi Plot
phi_list = [8 10 12 14 16 18];     
hold on;  % keep contour plot

% Define range of h_leg to compute over (should match ylim)
h_leg_curve = linspace(0.05, 0.1, 200);

% Create shades of gray: lighter gray for smaller phi, darker gray for larger phi
n_phi = length(phi_list);
gray_colors = linspace(0.2, 0.8, n_phi);  % values between 0=black, 1=white

for i = 1:n_phi
    phi_deg = phi_list(i);
    phi_rad = deg2rad(phi_deg);   % convert to radians
    
    % Compute r_leg from the formula
    r_leg_curve = (r_ball - h_leg_curve) .* tan(phi_rad) + ...
                  (r_ball - h_leg_curve) ./ cos(phi_rad) .* ...
                  (r_ball - (r_ball - h_leg_curve) ./ cos(phi_rad)) ./ ...
                  (r_ball - h_leg_curve) ./ tan(phi_rad);
    
    % Define gray color for this phi
    c = gray_colors(i);

    % Plot the curve (dashed black line)
    plot(r_leg_curve, h_leg_curve, '--', 'Color', [c c c]);
end

hold off;

% Right narrow subplot for colorbar
ax2 = subplot(1,16,15:16);
% Create invisible fake image covering phi range
% X-data doesn't matter (it's 2 pixels wide); Y-data is phi_list
fake_img = imagesc([0 1], [1 n_phi], (1:n_phi)');   
clim(ax2, [0.5 n_phi+0.5]);
set(fake_img, 'Visible','off');  % hide the actual strip

% Apply greyscale colormap only to this subplot
colormap(ax2, [gray_colors(:) gray_colors(:) gray_colors(:)]);
% Remove ticks and frame
set(ax2, 'XTick',[], 'YTick',[], 'Visible','off');
% Add colorbar to ax2
cb = colorbar(ax2, 'Location','eastoutside');
cb.Label.String = '\phi_{max} [deg]';
cb.Ticks = 1:n_phi;
cb.TickLabels = arrayfun(@num2str, phi_list, 'UniformOutput', false);
cb.FontSize = 14;
cb.Label.FontSize = 16;
cb.Position(3) = cb.Position(3) * 2;   % make colorbar itself thicker
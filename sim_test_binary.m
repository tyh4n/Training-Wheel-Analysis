%% Init 
r_ring_arr = linspace(0.25, 0.4, 10);     % Ring radius [m] 
h_leg_arr = linspace(0.05, 0.10, 10);      % Leg distance from ground [m]
v_crit = zeros(length(h_leg_arr), length(r_ring_arr));

%% Binary Splitting Evaluation
for r_idx = 1 : length(r_ring_arr)
    for h_idx = 1 : length(h_leg_arr)
        disp('Setup # ');
        disp((r_idx - 1) * length(h_leg_arr) + h_idx);
        disp('Percentage: ');
        disp(((r_idx - 1) * length(h_leg_arr) + h_idx) / (length(h_leg_arr) * length(r_ring_arr)) * 100);

        r_ring = r_ring_arr(r_idx);
        h_leg = h_leg_arr(h_idx);

        accel_time_l = 2;
        accel_time_r = 6;
        accel_time_m = (accel_time_l + accel_time_r) / 2;
        
        while (accel_time_r - accel_time_l) > 0.2
            accel_time = accel_time_m;
        
            sim_out = sim('ballbot_isp', 'StopTime', '10');    
            
            tout = sim_out.get('tout');
            % Check if simulation ran to completion
            if tout(end) < 10
                disp('Simulation was interrupted!');
                accel_time_r = accel_time_m;
            else
                disp('Simulation completed normally.');
                accel_time_l = accel_time_m;
            end
        
            accel_time_m = (accel_time_l + accel_time_r) / 2;
        end
        
        idx = find(abs(sim_out.v_body.time - 7) < 0.001);
        v_crit(h_idx, r_idx) = sim_out.v_body.data(idx(1));
    end
end

%% Save data
save("isp_2s6s_025040510_miu1_10x10.mat","r_ring_arr", "h_leg_arr", "v_crit");

%% Plot
[X,Y] = meshgrid(r_ring_arr, h_leg_arr);
% surf(X, Y, v_crit);
colormap(winter);
[C,h] = contour(X,Y,v_crit);
clabel(C,h, 'FontSize', 16);
xlabel("r_{leg} [m]");
ylabel("h_{leg} [m]");
zlabel("v_{critical} [m/s]");
% view(-45,45);
% shading interp;
% colorbar;
fontsize(16,"points");
xlim([0.25, 0.4]);
ylim([0.05, 0.1]);
zlim([0, 4]);

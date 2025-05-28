%% Linear Evaluation
accel_time_arr = linspace(0.2, 5, 5);

for i = 1:length(accel_time_arr)
    accel_time = accel_time_arr(i);
    % Run simulation
    sim_out = sim('ballbot', 'StopTime', '10');  
    
    tout = sim_out.get('tout');
    % Check if simulation ran to completion
    if tout(end) < 10
        disp('Simulation was interrupted!');
    else
        disp('Simulation completed normally.');
    end

    video_file_name = "test" + num2str(i);
    smwritevideo("ballbot", video_file_name);
end


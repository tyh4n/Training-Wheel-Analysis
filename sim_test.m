% Start simulation in normal mode
accel_time_arr = linspace(0.2, 5, 5);

for i = 1:length(accel_time_arr)
    fail_flag = 0;

    accel_time = accel_time_arr(i);
    sim_out = sim('ballbot');

    if fail_flag ~= 0
        disp("System failed")
    end

    video_file_name = "test" + num2str(i);
    smwritevideo("ballbot", video_file_name);
end


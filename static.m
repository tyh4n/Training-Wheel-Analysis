%% Init
max_tilt = 18;      % [degree] 
max_wid = 10;       % [in]

%% Distance to center vs. ground clearance
d_2_center = linspace(0, max_wid); % Distance to center in inches

angles = [5, 7.5, 10, 12.5, 15, max_tilt]; % Replace with your actual angles

% Generate a color gradient using a colormap
num_angles = length(angles);
% Define light and dark colors in RGB
light_color = [1, 0.9, 0.6]; % Light orange/yellow (RGB)
dark_color = [0.6, 0.2, 0]; % Dark brown/orange (RGB)

% Create a gradient from light to dark
colors = [linspace(light_color(1), dark_color(1), num_angles)', ...
          linspace(light_color(2), dark_color(2), num_angles)', ...
          linspace(light_color(3), dark_color(3), num_angles)'];
figure('Position', [100, 100, 800, 600]); % [left, bottom, width, height]
hold on;
for i = 1:num_angles
    % Calculate ground clearance for the current angle
    ground_clearance = d_2_center * tand(angles(i));
    
    % Plot with the corresponding color
    plot(d_2_center, ground_clearance, 'Color', colors(i, :), 'LineWidth', 1.5);
end
hold off;

grid on;
xlabel('Distance to center [in]');
ylabel('Ground clearance [in]');
legend_labels = string(angles) + '°'; % Add degree symbol to legend labels
legend(legend_labels, 'Location', 'best'); % Add legend

% Add a secondary x-axis for millimeters
ax1 = gca; % Get the current axis
ax2 = axes('Position', ax1.Position, 'XAxisLocation', 'top', 'Color', 'none'); % Create a secondary axis
ax2.XLim = ax1.XLim * 25.4; % Convert inches to millimeters (1 inch = 25.4 mm)
xlabel(ax2, 'Distance to center [mm]');

% Align the secondary x-axis with the primary axis
ax2.YLim = ax1.YLim;
ax2.YTick = []; % Hide the y-axis ticks for the secondary axis

% Add a secondary y-axis for millimeters on the right side
yyaxis right; % Activate the right y-axis
ax1_right = gca; % Get the right y-axis
ax1_right.YLim = ax1.YLim * 25.4; % Convert inches to millimeters
ylabel('Ground clearance [mm]');

% Hide the right y-axis plot (no second curve)
ax1_right.Color = 'none'; % Make the right y-axis transparent
ax1_right.YColor = 'k'; % Set the color of the right y-axis labels

% Set font size for tick labels
set(ax1, 'FontSize', 16); % Set font size for primary axis tick labels
set(ax2, 'FontSize', 16); % Set font size for secondary x-axis tick labels
set(ax1_right, 'FontSize', 16); % Set font size for secondary y-axis tick labels


%% Tilt vs. accel
g = 9.81;  % [m/s^2]
tilt = linspace(0, 20, 100);
accel = g * tand(tilt);
figure('Position', [100, 100, 800, 600]);
plot(tilt, accel);
grid on;
xlabel('Tilt angle [degree]');
ylabel('Acceleration [m/s^2]');
ax1 = gca; % Get the current axis
set(ax1, 'FontSize', 16); % Set font size for primary axis tick labels
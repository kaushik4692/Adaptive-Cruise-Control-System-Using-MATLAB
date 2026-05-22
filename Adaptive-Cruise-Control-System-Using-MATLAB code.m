clc;
clear;
close all;

%% Simulation Settings

dt = 0.1;
t = 0:dt:60;

%% Desired Speed

desired_speed = 25;

%% Lead Vehicle Speed Profile

lead_speed = 20*ones(size(t));

lead_speed(t>=20) = 10;
lead_speed(t>=40) = 22;

%% Initialization

ego_speed = zeros(size(t));

lead_pos = zeros(size(t));
ego_pos = zeros(size(t));

lead_pos(1) = 100;

%% ACC Parameters

safe_distance = 40;

%% PID Parameters

Kp = 0.35;
Ki = 0.002;
Kd = 0.40;

integral_error = 0;
previous_error = 0;

%% Simulation Loop

for k = 1:length(t)-1

    current_distance = lead_pos(k) - ego_pos(k);

    relative_speed = ego_speed(k) - lead_speed(k);

    % ACC Target Speed Logic

    target_speed = desired_speed;

    % Distance control

    if current_distance < 80

        target_speed = min(target_speed,...
            lead_speed(k) + 0.20*(current_distance-safe_distance));

    end

    % Closing-speed penalty

    if relative_speed > 0

        target_speed = target_speed ...
            - 0.8*relative_speed;

    end

    % Never command impossible speeds

    target_speed = max(0,target_speed);
    target_speed = min(desired_speed,target_speed);

    % PID Controller

    error = target_speed - ego_speed(k);

    integral_error = integral_error + error*dt;

    integral_error = max(min(integral_error,50),-50);

    derivative_error = (error - previous_error)/dt;

    acceleration = ...
        Kp*error + ...
        Ki*integral_error + ...
        Kd*derivative_error;

    previous_error = error;

    % Vehicle limits

    acceleration = max(min(acceleration,2.5),-6);

    % Speed update

    ego_speed(k+1) = ego_speed(k) + acceleration*dt;

    ego_speed(k+1) = max(0,ego_speed(k+1));
    ego_speed(k+1) = min(desired_speed,ego_speed(k+1));

    % Position update

    lead_pos(k+1) = lead_pos(k) + lead_speed(k)*dt;

    ego_pos(k+1) = ego_pos(k) + ego_speed(k+1)*dt;

end

%% Distance

distance = lead_pos - ego_pos;

%% Metrics

minimum_distance = min(distance)

maximum_speed = max(ego_speed)

final_speed = ego_speed(end)

%% Plots

figure

subplot(2,1,1)

plot(t,lead_speed,'LineWidth',2)
hold on
plot(t,ego_speed,'LineWidth',2)

grid on

legend('Lead Vehicle','Ego Vehicle')

ylabel('Speed (m/s)')

title('Adaptive Cruise Control System')

subplot(2,1,2)

plot(t,distance,'LineWidth',2)

grid on

xlabel('Time (s)')
ylabel('Distance (m)')

title('Following Distance')
function [t, omega] = simulateDCMotorPID(J, B, Kt, Ke, R, Kp, Ki, Kd, setpoint)
    % Desired speed setpoint
    % setpoint = 100; % rad/s (desired angular velocity)

    % Time vector
    t = 0:0.01:5; % 5 seconds, step size 0.01s

    % Preallocate output
    omega = zeros(size(t)); % Angular velocity (rad/s)
    current = zeros(size(t)); % Motor current (A)
    e_prev = 0;
    integral = 0;

    for i = 2:length(t)
        % Error calculation
        e = setpoint - omega(i-1);

        % Proportional term
        P = Kp * e;

        % Integral term (with clamping to prevent windup)
        integral = integral + e * 0.01; % Integral of error over time
        integral = max(min(integral, 10), -10); % Clamping the integral term
        I = Ki * integral;

        % Derivative term
        derivative = (e - e_prev) / 0.01; % Derivative of error
        D = Kd * derivative;

        % Control signal (input voltage) with clamping
        V = P + I + D;
        V = max(min(V, 24), -24); % Clamping voltage to +/- 24V (realistic motor range)

        % Electrical dynamics: Current calculation
        current(i) = (V - Ke * omega(i-1)) / R;

        % Mechanical dynamics: Angular acceleration
        torque = Kt * current(i);
        alpha = (torque - B * omega(i-1)) / J;

        % Update angular velocity (Euler integration)
        omega(i) = omega(i-1) + alpha * 0.01;

        % Update previous error
        e_prev = e;
    end
end
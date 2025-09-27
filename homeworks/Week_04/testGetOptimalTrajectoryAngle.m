function testGetOptimalTrajectoryAngle()
    % Test case 1: Basic scenario with velocity = 50 m/s, initial height = 0 m
    v0 = 50;
    y0 = 0;
    g = 9.81;
    
    [optimal_angle, max_range] = getOptimalTrajectoryAngle(v0, y0, g);

    theta = 0:90;
    range = (v0 .* cosd(theta) / g) .* (v0 .* sind(theta) + sqrt((v0 .* sind(theta)).^2 + 2 * g * y0));
    [expected_range, idx] = max(range);
    expected_angle = theta(idx);

    assert(abs(optimal_angle - expected_angle) < 1e-10, ...
        'Error: Optimal angle should match the maximizing angle.');
    assert(abs(max_range - expected_range) < 1e-5, ...
        'Error: Maximum range should match the computed range.');

    range_at_reported = (v0 * cosd(optimal_angle) / g) * ...
        (v0 * sind(optimal_angle) + sqrt((v0 * sind(optimal_angle))^2 + 2 * g * y0));
    assert(abs(range_at_reported - max_range) < 1e-5, ...
        'Error: Returned range must match the reported optimal angle.');
    
    % Test case 2: Scenario with initial height of 10 meters
    y0 = 10;
    [optimal_angle, max_range] = getOptimalTrajectoryAngle(v0, y0, g);

    range = (v0 .* cosd(theta) / g) .* (v0 .* sind(theta) + sqrt((v0 .* sind(theta)).^2 + 2 * g * y0));
    [expected_range, idx] = max(range);
    expected_angle = theta(idx);

    assert(abs(optimal_angle - expected_angle) < 1e-10, ...
        'Error: Optimal angle should match the maximizing angle for nonzero height.');
    assert(abs(max_range - expected_range) < 1e-5, ...
        'Error: Maximum range should match the computed range for nonzero height.');

    range_at_reported = (v0 * cosd(optimal_angle) / g) * ...
        (v0 * sind(optimal_angle) + sqrt((v0 * sind(optimal_angle))^2 + 2 * g * y0));
    assert(abs(range_at_reported - max_range) < 1e-5, ...
        'Error: Returned range must match the reported optimal angle for nonzero height.');
    
    disp('testGetOptimalTrajectoryAngle passed');
end

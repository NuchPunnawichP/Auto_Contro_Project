function draw_MBK2(y1, y2, u, Ms, Ks, Bs, w, color)
    % DRAW_MBK2 Visualize a 2-DOF spring-damper system
    % y1: Position of mass 1
    % y2: Position of mass 2
    % u: Road disturbance (scalar)
    % Ms: Masses [M1, M2]
    % Ks: Spring constants [K1, K2]
    % Bs: Damping coefficients [B1, B2]
    % w: Width of the masses
    % color: Color of the masses

    % Ensure `u` is scalar
    if numel(u) > 1
        error('Input `u` must be a scalar representing road disturbance.');
    end

    % Ground level (adjusted for disturbance)
    ground_y = -2 + u;

    % Draw the road disturbance
    rectangle('Position', [-1.5, ground_y - 0.05, 3, 0.1], 'FaceColor', [0.5, 0.5, 0.5]);

    % Draw mass 1
    rectangle('Position', [-w/2-0.25, y1, w+0.5, 0.3], 'Curvature', 0.1, 'FaceColor', 'b', 'EdgeColor', 'k');

    % Draw spring and damper between ground and mass 1
    draw_spring([-0.3, ground_y], [-0.3, y2-1], 5, 0.1, 'k');
    draw_damper([0.3, ground_y], [0.3, y2-1], 'k');

    % Draw mass 2
    rectangle('Position', [-w/2, y2-1, w, 0.2], 'Curvature', 0.1, 'FaceColor', 'g', 'EdgeColor', 'k');

    % Draw spring and damper between mass 1 and mass 2
    draw_spring([-0.3, y1], [-0.3, y2+0.2-1], 5, 0.1, 'k');
    draw_damper([0.3, y1], [0.3, y2+0.2-1], 'k');

    % Draw ground line (updated to road disturbance level)
    line([-1.5, 1.5], [ground_y, ground_y], 'Color', 'k', 'LineWidth', 1);

    % Adjust axes for visualization
    axis equal;
    xlim([-1.5, 1.5]);
    ylim([-1, 2]);
end

function draw_spring(p1, p2, num_coils, width, color)
    % DRAW_SPRING Draw a spring between two points
    % p1: Start point [x, y]
    % p2: End point [x, y]
    % num_coils: Number of coils in the spring
    % width: Width of the spring
    % color: Color of the spring

    x1 = p1(1); y1 = p1(2);
    x2 = p2(1); y2 = p2(2);

    spring_length = sqrt((x2 - x1)^2 + (y2 - y1)^2);
    coil_height = spring_length / (num_coils * 2);

    % Generate spring points
    t = linspace(0, 2*pi*num_coils, 100);
    x = width * sin(t) + (x1 + x2) / 2;
    y = linspace(y1, y2, length(t)) + coil_height * cos(t);

    line(x, y, 'Color', color, 'LineWidth', 1.5);
end

function draw_damper(p1, p2, color)
    % DRAW_DAMPER Draw a damper between two points
    % p1: Start point [x, y]
    % p2: End point [x, y]
    % color: Color of the damper

    x1 = p1(1); y1 = p1(2);
    x2 = p2(1); y2 = p2(2);

    % Damper dimensions
    damper_height = 0.1;

    % Draw the line connecting damper
    line([x1, x1], [y1, y1 + (y2 - y1) / 2], 'Color', color, 'LineWidth', 2);
    line([x1, x2], [y1 + (y2 - y1) / 2, y1 + (y2 - y1) / 2], 'Color', color, 'LineWidth', 2);
    line([x2, x2], [y1 + (y2 - y1) / 2, y2], 'Color', color, 'LineWidth', 2);

    % Draw the damper box
    rectangle('Position', [x1 - 0.05, y1 + (y2 - y1) / 2 - damper_height / 2, 0.1, damper_height], ...
              'Curvature', 0.1, 'FaceColor', color, 'EdgeColor', 'k');
end

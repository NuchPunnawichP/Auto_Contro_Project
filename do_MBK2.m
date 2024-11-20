clear, clf
global M1 M2 K1 K2 B1 B2 

M1 = 1300/4; % ¼ Mass of car
M2 = 225; % Suspension Mass
K1 = 24200; % Spring constant of Suspension System
K2 = 205000; % Spring constant of Wheel and tire
B1 = 350; % Damping constant of Suspension System
B2 = 1500;

t0 = 0; tf = 5; tspan = [t0 tf];
x0 = [1.5; 0.5; 0; 0];
[tt, xx] = ode45(@dxdt, linspace(t0, tf, 100), x0); % Fewer points for efficiency

Ms = [M1 M2]; Ks = [K1 K2]; Bs = [B1 B2];
animation = 1; w = 1;

if animation < 1
    plot(tt, u(tt), tt, xx(:, 1:2));
    legend('u(t)', 'y_1 (t)', 'y_2 (t)');
else
    for n = 1:numel(tt)
        t = tt(n); tp = t; shg
        subplot(121), cla
        draw_MBK2(xx(n, 1), xx(n, 2), u(t), Ms, Ks, Bs, w, 'b');
        axis([-1.5 1.5 -1 2]), axis('equal')
        subplot(122)
        plot(t, u(t), 'r.', t, xx(n, 1), 'b.', t, xx(n, 2), 'g.');
        axis([0 tf -1 2]), hold on     
        if n > 1, pause(0.01); end
    end  
    
    % Add a new subplot for the difference
    figure;
    plot(tt, xx(:, 2) - xx(:, 1), 'k', 'LineWidth', 1.5);
    title('Difference y_2 - y_1 Over Time');
    xlabel('Time (s)');
    ylabel('Difference (y_2 - y_1)');
    grid on;
end

set(gcf, 'color', 'white');
shg

function dx = dxdt(t, x)
global M1 M2 K1 K2 B1 B2
A = [ 0          0        1       0;
      0          0        0       1;
     -K1/M1    K1/M1   -B1/M1    B1/M1;
      K1/M2 -(K1+K2)/M2 B1/M2 -(B1+B2)/M2]; 
dx = A * x + [0; 0; 0; (K2*u(t) + B2*du(t))/M2];
end 

function u = u(t)
u = 0.2 * sin(3 * t); % Road disturbance
end

function du = du(t)
dt = 1e-3; du = (u(t + dt) - u(t)) / dt;
end

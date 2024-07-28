% вхідні дані
n = 23;
s_0 = sqrt(23);
v = sqrt(23);
l = 23;
fi = pi * 23 / 25;

disp('INPUT DATA');
disp(['n = ', num2str(n)]);
disp(['s_0 = ', num2str(s_0)]);
disp(['v = ', num2str(v)]);
disp(['l = ', num2str(l)]);
disp(['fi = ', num2str(fi)]);



N_N = 6;
N_values = linspace(10, 10000, N_N);  % генерація N

function [u_1, u_2] = calculate_control(x_1, x_2, s_0, v, l, fi, tau)

    % формула для λ
    lambda = sqrt((l*cos(fi) - x_1 - s_0 * x_2 * tau)^2 +
    (l*sin(fi) - x_2)^2) * v * tau - v^2 * tau^2;

    % формули для u1, u2
    u_1 = ((l*cos(fi) - x_1 - s_0 * x_2 * tau) * v * tau) / (lambda + v^2 * tau^2);
    u_2 = ((l*sin(fi) - x_2) * v * tau) / (lambda + v^2 * tau^2);
end

figure;
hold on;

colors = lines(N_N);
final_points = zeros(N_N, 2);

for j = 1:N_N

    N = N_values(j);
    tau = (l / v) / N;

    x_1 = 0;
    x_2 = 0;

    x_1_values = zeros(1, N+1);
    x_2_values = zeros(1, N+1);

    for i = 1:N
        [u_1, u_2] = calculate_control(x_1, x_2, s_0, v, l, fi, tau);

        x_1 = x_1 + (s_0 * x_2 + v * u_1) * tau;
        x_2 = x_2 + v * u_2 * tau;

        x_1_values(i+1) = x_1;
        x_2_values(i+1) = x_2;

    end
    time = l/v;
    plot(x_1_values, x_2_values, 'DisplayName', ['N = ', num2str(N), ', Час: ', num2str(time)], 'Color', colors(j, :));

    final_points(j, :) = [l*cos(fi), l*sin(fi)];
end

xlabel('X_1', 'FontSize', 20);
ylabel('X_2', 'FontSize', 20);
title('Траєкторія переміщення човна залежно від N', 'FontSize', 20);
grid on;
set(gca, 'FontSize', 16);
legend('show');

scatter(final_points(:, 1), final_points(:, 2), 30, colors, 'filled', 'DisplayName', ['Фінальна точка']);

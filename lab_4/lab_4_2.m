% ===== Пункт 1 (из первого задания) =====
fprintf('Пункт 1 (из первого задания)\n');
a = 2.5;
b = 3.1;
n = 3; % number of intervals
x_nodes = a + (0:n) * (b - a) / n;
disp(x_nodes);
fprintf('\n\n');

% Исходная функция
f = @(x) x .* log(sqrt(x - 2));




% ===== Пункт 1 =====
% Вычисление коэффициентов для полинома Ньютона
function coeffs = newton_coeffs(x, y)
    n = length(x);
    coeffs = y;
    for i = 2:n
        for j = n:-1:i
            coeffs(j) = (coeffs(j) - coeffs(j-1)) / (x(j) - x(j-i+1));
        end
    end
end

% Полином Ньютона
function P = newton_poly(x, coeffs, xi)
    n = length(coeffs);
    P = coeffs(n);
    for i = n-1:-1:1
        P = coeffs(i) + (xi - x(i)) .* P;
    end
end

% Узлы равномерной сетки
y_nodes = f(x_nodes);
uniform_coeffs = newton_coeffs(x_nodes, y_nodes);




% ===== Пункт 2 =====
% Точки для вычисления
x_j = [(5*a + b)/6, (a + b)/2, (a + 5*b)/6];
f_xj = f(x_j);
P3r_xj = arrayfun(@(xi) newton_poly(x_nodes, uniform_coeffs, xi), x_j);
errors_uniform = abs(f_xj - P3r_xj);

% Вывод результатов пункта 2
fprintf('Пункт 2\n');
disp('x_j:');
disp(x_j);
disp('f(x_j):');
disp(f_xj);
disp('P3^r(x_j):');
disp(P3r_xj);
disp('|f(x_j) - P3^r(x_j)|:');
disp(errors_uniform);
fprintf('\n\n');




% ===== Пункт 3 =====
% Построение графиков
figure;
hold on;
fplot(f, [a, b], 'b', 'LineWidth', 1.5); % Исходная функция
plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 8, 'DisplayName', 'Узлы (равномерные)');
plot(x_j, P3r_xj, 'gx', 'MarkerSize', 8, 'DisplayName', 'P_3^r(x_j)');
legend('Исходная функция f(x)', 'Узлы интерполяции', 'Полином Ньютона');
title('График функции и полинома Ньютона (равномерная сетка)');
grid on;
hold off;




% ===== Пункт 4 =====
% Узлы Чебышевской сетки
chebyshev_nodes = a + (b - a) * (1 - cos((2*(1:n+1)-1)*pi/(2*(n+1)))) / 2;
y_chebyshev = f(chebyshev_nodes);
chebyshev_coeffs = newton_coeffs(chebyshev_nodes, y_chebyshev);




% ===== Пункт 5 =====
% Вычисление значений для Чебышевской сетки
P3c_xj = arrayfun(@(xi) newton_poly(chebyshev_nodes, chebyshev_coeffs, xi), x_j);
errors_chebyshev = abs(f_xj - P3c_xj);

% Вывод результатов задания 15
fprintf('Пункт 5\n');
disp('P3^c(x_j):');
disp(P3c_xj);
disp('|f(x_j) - P3^c(x_j)|:');
disp(errors_chebyshev);
fprintf('\n\n');




% ===== Пункт 6 =====
% Построение графиков
figure;
hold on;
fplot(f, [a, b], 'b', 'LineWidth', 1.5);
plot(chebyshev_nodes, y_chebyshev, 'ro', 'MarkerSize', 8, 'DisplayName', 'Узлы (Чебышевские)');
plot(x_j, P3c_xj, 'gx', 'MarkerSize', 8, 'DisplayName', 'P_3^c(x_j)');
legend('Исходная функция f(x)', 'Узлы интерполяции (Чебышев)', 'Полином Ньютона');
title('График функции и полинома Ньютона (Чебышевская сетка)');
grid on;
hold off;




% ===== Пункт 7 =====
% Заполнение таблицы
fprintf('Пункт 7\n');
fprintf('| j | x_j       | f(x_j)     | P_3^r(x_j)  | f(x_j) - P_3^r(x_j) | P_3^c(x_j)  | f(x_j) - P_3^c(x_j) |\n');
fprintf('|---|-----------|------------|-------------|----------------------|-------------|---------------------|\n');
for j = 1:length(x_j)
    fprintf('| %d | %.6f | %.6f | %.6f | %.6f           | %.6f | %.6f          |\n', ...
        j-1, x_j(j), f_xj(j), P3r_xj(j), errors_uniform(j), P3c_xj(j), errors_chebyshev(j));
end
fprintf('\n\n');




% ===== Пункт 8 =====
% Построение графиков погрешностей
figure;
hold on;
plot(x_j, errors_uniform, 'r-o', 'DisplayName', 'Погрешность (равномерная сетка)');
plot(x_j, errors_chebyshev, 'g-x', 'DisplayName', 'Погрешность (Чебышевская сетка)');
legend('show');
title('Графики погрешностей интерполяции');
grid on;
hold off;

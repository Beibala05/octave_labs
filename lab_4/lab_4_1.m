% ===== Пункт 1 =====
fprintf('Пункт 1\n');
a = 2.5;
b = 3.1;
n = 3; % number of intervals
x_nodes = a + (0:n) * (b - a) / n;
disp(x_nodes);
fprintf('\n\n');



% ===== Пункт 2 =====
function L = lagrange_poly(x, x_nodes, f_values)
    n = length(x_nodes);
    L = 0;
    for i = 0:n-1
        L_i = f_values(i+1);
        for j = 0:n-1
            if i != j
                L_i = L_i * (x - x_nodes(j+1)) / (x_nodes(i+1) - x_nodes(j+1));
            end
        end
        L = L + L_i;
    end
end


f_values = arrayfun(@(x) x*log(sqrt(x - 2)), x_nodes);




% ===== Пункт 3 =====
fprintf('Пункт 3\n');
x_j = [(5*a + b)/6, (a + b)/2, (a + 5*b)/6];
L_values = arrayfun(@(x) lagrange_poly(x, x_nodes, f_values), x_j);
f_values_j = arrayfun(@(x) x*log(sqrt(x - 2)), x_j);
errors = abs(f_values_j - L_values);

disp('x_j значения:');
disp(x_j);
disp('L_3^r(x_j) значения:');
disp(L_values);
disp('f(x_j) значения:');
disp(f_values_j);
disp('Погрешность:');
disp(errors);
fprintf('\n\n');




% ===== Пункт 4 =====
x = linspace(2.5, 3.1, 100);
f_values_plot = arrayfun(@(x) x*log(sqrt(x - 2)), x);
L_values_plot = arrayfun(@(x) lagrange_poly(x, x_nodes, f_values), x);

figure;
plot(x, f_values_plot, 'b-', 'LineWidth', 2);
hold on;
plot(x, L_values_plot, 'r--', 'LineWidth', 2);
scatter(x_nodes, f_values, 'ko', 'filled');
title('Сравнение функции и полинома Лагранжа');
xlabel('x');
ylabel('y');
legend('f(x)', 'L_3^r(x)', 'Interpolation Nodes');
grid on;



% ===== Пункт 5 =====
fprintf('Пункт 5\n');
chebyshev_nodes = (a + b)/2 + (b - a)/2 * cos((2*(0:n) + 1) / 8 * pi);
f_chebyshev_values = arrayfun(@(x) x*log(sqrt(x - 2)), chebyshev_nodes);

disp('Узлы Чебышева:');
disp(chebyshev_nodes);
disp('f(Узлы Чебышева):');
disp(f_chebyshev_values);
fprintf('\n\n');



% ===== Пункт 6 =====
fprintf('Пункт 6\n');
L_chebyshev_values = arrayfun(@(x) lagrange_poly(x, chebyshev_nodes, f_chebyshev_values), x_j);
disp('L_3^c(x_j) значения:');
disp(L_chebyshev_values);
fprintf('\n\n');




% ===== Пункт 7 =====
fprintf('Пункт 7\n');
errors_chebyshev = abs(f_values_j - L_chebyshev_values);
disp('Погрешности для Чебышевских узлов');
disp(errors_chebyshev);
fprintf('\n\n');




% ===== Пункт 8 =====
L_values_chebyshev_plot = arrayfun(@(x) lagrange_poly(x, chebyshev_nodes, f_chebyshev_values), x);

figure;
plot(x, f_values_plot, 'b-', 'LineWidth', 2);
hold on;
plot(x, L_values_chebyshev_plot, 'r--', 'LineWidth', 2);
scatter(chebyshev_nodes, f_chebyshev_values, 'ko', 'filled');
title('Сравнение функции и полинома Лагранжа с Чебышевскими узлами');
xlabel('x');
ylabel('y');
legend('f(x)', 'L_3^c(x)', 'Чебышевы узлы');
grid on;




% ===== Пункт 9 =====
fprintf('Пункт 9\n');
function y = f(x)
    if x < 2
        error('Функция f не определена для x < 2');
    end
    y = x * log(sqrt(x - 2));
end


nodes = [2.6, 2.8, 3.0];
f_values = arrayfun(@(x) f(x), nodes);
chebyshev_nodes = cos(((2*(0:length(nodes)-1) + 1) .* pi) ./ (2*length(nodes))) + 1;
chebyshev_nodes = 2 + (chebyshev_nodes + 1);
f_chebyshev_values = arrayfun(@(x) f(x), chebyshev_nodes);


function L = lagrange_poly(x, nodes, f_values)
    L = 0;
    n = length(nodes);
    for i = 1:n
        p = 1;
        for j = 1:n
            if j != i
                p = p * (x - nodes(j)) / (nodes(i) - nodes(j));
            end
        end
        L = L + f_values(i) * p;
    end
end

% Вычисление полиномов Лагранжа для равномерной и Чебышевской сетки
L_3_r_values = arrayfun(@(x) lagrange_poly(x, nodes, f_values), nodes);
L_3_c_values = arrayfun(@(x) lagrange_poly(x, chebyshev_nodes, f_chebyshev_values), chebyshev_nodes);

% Вычисление погрешностей
errors_r = f_values - L_3_r_values;
errors_c = f_chebyshev_values - L_3_c_values;


disp('  j   |      x_j     |       f(x_j)     |  L_3^r(x_j)   | f(x_j) - L_3^r(x_j) |  L_3^c(x_j)   | f(x_j) - L_3^c(x_j)');
disp('------+---------------+------------------+----------------+----------------------+----------------+-----------------------');

for j = 1:length(nodes)
    fprintf('%3d   | %12.6f | %16.6f | %14.6f | %20.6f | %14.6f | %20.6f\n', ...
        j, nodes(j), f_values(j), L_3_r_values(j), errors_r(j), L_3_c_values(j), errors_c(j));
end
fprintf('\n\n');




% ===== Пункт 10 =====
fprintf('Пункт 10\n');
% Задаем значения функции
f = @(x) x .* log(sqrt(x - 2)); % Функция f(x) = x * ln(sqrt(x - 2))

% Количество узлов
n = 5;

% Равномерная сетка
x_uniform = linspace(2.6, 3.0, n);
f_values_uniform = f(x_uniform);

% Чебышёвская сетка
x_chebyshev = cos((2*(0:n-1) + 1) * pi / (2*n)) * (0.2) + 2.8; % Приведем узлы к диапазону [2.6, 3.0]
f_values_chebyshev = f(x_chebyshev);

% Функция для вычисления полинома Лагранжа
function L = lagrange_interpolation(x, xj, fj)
    m = length(xj);
    L = zeros(size(x));
    for j = 1:m
        p = ones(size(x));
        for k = [1:j-1, j+1:m]
            p = p .* (x - xj(k)) / (xj(j) - xj(k));
        end
        L = L + p * fj(j);
    end
end

% Интерполяция на узлах
x_eval = linspace(2.5, 3.1, 100);
L_uniform = lagrange_interpolation(x_eval, x_uniform, f_values_uniform);
L_chebyshev = lagrange_interpolation(x_eval, x_chebyshev, f_values_chebyshev);

% Вычисляем Погрешности
errors_uniform = f(x_eval) - L_uniform;
errors_chebyshev = f(x_eval) - L_chebyshev;

% Визуализация
figure;
hold on; 
plot(x_eval, f(x_eval), 'k', 'DisplayName', 'f(x) = x * ln(sqrt(x - 2))');
plot(x_eval, L_uniform, 'b--', 'DisplayName', 'L(x) на равномерной сетке');
plot(x_eval, L_chebyshev, 'r--', 'DisplayName', 'L(x) на Чебышёвской сетке');
legend show;
grid on;
title('Интерполяция Лагранжа');
xlabel('x');
ylabel('f(x)');
hold off;

% Вывод погрешностей
max_error_uniform = max(abs(errors_uniform));
max_error_chebyshev = max(abs(errors_chebyshev));
fprintf('Максимальная ошибка для равномерной сетки: %f\n', max_error_uniform);
fprintf('Максимальная ошибка для Чебышёвской сетки: %f\n', max_error_chebyshev);
fprintf('\n\n');
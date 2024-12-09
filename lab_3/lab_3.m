% Пункт 1, Задание 1
x1 = linspace(-3, 3, 100);
g1 = 0.8 - cos(x1 + 0.5);
g2 = asin(2*x1 + 1.6);

figure;
plot(x1, g1, 'b', 'DisplayName', 'g1(x1)');
hold on;
plot(x1, g2, 'r', 'DisplayName', 'g2(x1)');
title('Графики g1 и g2');
xlabel('x1');
ylabel('x2');
legend;
grid on;
hold off;




% Пункт 2, Задание 1
% Привести уравниение к итерационному виду



% Пункт 3, Задание 1
fprintf('Пункт 3, Задание 1\n');
% Начальные приближения
x1_0 = 0;
x2_0 = 0;

tolerance = 0.00001;
max_iter = 100;
for k = 1:max_iter
    x1_next = 0.5 * (sin(x2_0) - 1.6);
    x2_next = 0.8 - cos(x1_0 + 0.5);

    % Вычисление матрицы Якоби
    J = [0.5 * cos(x2_0), -0.5 * sin(x1_0 + 0.5);
         2 * cos(x2_next), sin(x1_0 + 0.5)];

    % Вычисление нормы якобиана
    norm_J = norm(J);

    % Проверка сходимости
    if abs(x1_next - x1_0) < tolerance && abs(x2_next - x2_0) < tolerance
        break;
    end

    % Обновление значений
    x1_0 = x1_next;
    x2_0 = x2_next;
end

fprintf('Сошлось к (%f, %f) после %d итераций с нормой J = %f\n', x1_0, x2_0, k, norm_J);
fprintf('\n\n');



% Пункт 4, Задание 1
fprintf('Пункт 4, Задание 1\n');
% Определение функций итерации
function x2_next = phi1(x2)
    x2_next = 0.8 - cos(x2 + 0.5);
end

function x1_next = phi2(x1)
    x1_next = 0.5 * (sin(x1) - 1.6);
end

% Начальные приближения
x1_0 = 0.0;
x2_0 = 0.0;

% Параметры для итераций
tolerance = 0.00001;
max_iter = 100;

% Инициализация для таблицы
iter_data = zeros(max_iter, 4); % Номер итерации, x1, x2, разница

% Итерационный процесс 
for k = 1:max_iter
    % Обновляем значения
    x1_next = phi2(x2_0);
    x2_next = phi1(x1_0);

    % Разница между текущими и предыдущими итерациями
    diff_x1 = abs(x1_next - x1_0);
    diff_x2 = abs(x2_next - x2_0);
    
    % Сохраняем данные в таблицу
    iter_data(k, 1) = k; % Номер итерации
    iter_data(k, 2) = x1_next; % x1_(k)
    iter_data(k, 3) = x2_next; % x2_(k)
    iter_data(k, 4) = max(diff_x1, diff_x2); % max(x_(k) - x_(k-1))

    % Условие остановки по точности
    if max(diff_x1, diff_x2) < tolerance
        break;
    end

    % Обновляем значения для следующей итерации
    x1_0 = x1_next;
    x2_0 = x2_next;
end

% Печатаем таблицу
fprintf('| Номер итерации | x1_(k) | x2_(k) | x_(k) - x_(k-1)| Точность |\n');
fprintf('|----------------|--------|--------|----------------| --------|\n');
for i = 1:k
    fprintf('| %d               | %.5f | %.5f | %.5f          | %.5f|\n', ...
            iter_data(i, 1), iter_data(i, 2), iter_data(i, 3), iter_data(i, 4), iter_data(i, 4));
end
fprintf('\n\n');



% Пункт 5, Задание 1
fprintf('Пункт 5, Задание 1\n');
% Определение номера итерации, на которой достигнута заданная точность
convergence_iteration = find(iter_data(:, 4) < tolerance, 1);
fprintf('Номер итерации, на которой достигнута заданная точность: %d\n', convergence_iteration);
fprintf('\n\n');



% Пункт 6, Задание 1
fprintf('Пункт 6, Задание 1\n');
% Решение системы на найденной итерации
if convergence_iteration > 0
    fprintf('Решение системы на итерации %d:\n', convergence_iteration);
    fprintf('x1^* = %.5f\n', iter_data(convergence_iteration, 2));
    fprintf('x2^* = %.5f\n', iter_data(convergence_iteration, 3));
else
    fprintf('Не удалось достичь заданной точности за %d итераций.\n', max_iter);
end
fprintf('\n\n');




% Пункт 1, Задание 2
% Определение функций f1 и f2
function f1_value = f1(x1, x2)
    f1_value = cos(x1 + 0.5) + x2 - 0.8;
end

function f2_value = f2(x1, x2)
    f2_value = -2*x1 + sin(x2) - 1.6;
end

% Определение частных производных
function df1_dx1 = df1_dx1(x1, x2)
    df1_dx1 = -sin(x1 + 0.5); % производная cos
end

function df1_dx2 = df1_dx2(x1, x2)
    df1_dx2 = 1; % производная по x2
end

function df2_dx1 = df2_dx1(x1, x2)
    df2_dx1 = -2; % производная по x1
end

function df2_dx2 = df2_dx2(x1, x2)
    df2_dx2 = cos(x2); % производная sin
end




% Пункт 2, Задание 2
fprintf('Пункт 2, Задание 2\n');
% Начальные приближения
x1_0 = 0.0; % Начальное значение x1
x2_0 = 0.0; % Начальное значение x2

% Параметры для итераций
tolerance = 0.00001;
max_iter = 100;

% Инициализация для таблицы
iter_data = zeros(max_iter, 4); % Номер итерации, x1, x2, разница

% Итерационный процесс
for k = 1:max_iter
    % Расчет значений
    J = [df1_dx1(x1_0, x2_0), df1_dx2(x1_0, x2_0); 
         df2_dx1(x1_0, x2_0), df2_dx2(x1_0, x2_0)];
    
    F = [f1(x1_0, x2_0); 
         f2(x1_0, x2_0)];
    
    % Проверим, является ли матрица J невырожденной
    if abs(det(J)) < eps
        fprintf('Матрица Якоби вырождена, итерации не могут продолжаться.\n');
        break;
    end

    % Решаем систему уравнений J * delta = -F
    delta = -J \ F;

    % Обновляем значения x1 и x2
    x1_next = x1_0 + delta(1);
    x2_next = x2_0 + delta(2);

    % Разница между текущими и предыдущими итерациями
    diff_x1 = abs(x1_next - x1_0);
    diff_x2 = abs(x2_next - x2_0);
    
    % Сохраняем данные в таблицу
    iter_data(k, 1) = k; % Номер итерации
    iter_data(k, 2) = x1_next; % x1_(k)
    iter_data(k, 3) = x2_next; % x2_(k)
    iter_data(k, 4) = max(diff_x1, diff_x2); % max(x_(k) - x_(k-1))

    % Условие остановки по точности
    if max(diff_x1, diff_x2) < tolerance
        break;
    end

    % Обновляем значения для следующей итерации
    x1_0 = x1_next;
    x2_0 = x2_next;
end

% Печатаем таблицу
fprintf('| Номер итерации | x1_(k) | x2_(k) | x_(k) - x_(k-1)| Точность |\n');
fprintf('|-----------------|--------|--------|----------------| --------|\n');
for i = 1:k
    fprintf('| %d               | %.5f | %.5f | %.5f          | %.5f|\n', ...
            iter_data(i, 1), iter_data(i, 2), iter_data(i, 3), iter_data(i, 4), iter_data(i, 4));
end
fprintf('\n\n');



% Пункт 3, Задание 2
fprintf('Пункт 3, Задание 2');
% Определение номера итерации, на которой достигнута заданная точность
convergence_iteration = find(iter_data(:, 4) < tolerance, 1);
fprintf('\nНомер итерации, на которой достигнута заданная точность: %d\n', convergence_iteration);
fprintf('\n\n');


% Пункт 4, Задание 2
fprintf('Пункт 4, Задание 2\n');
% Решение системы на найденной итерации
if convergence_iteration > 0
    fprintf('Решение системы на итерации %d:\n', convergence_iteration);
    fprintf('x1^* = %.5f\n', iter_data(convergence_iteration, 2));
    fprintf('x2^* = %.5f\n', iter_data(convergence_iteration, 3));
else
    fprintf('Не удалось достичь заданной точности за %d итераций.\n', max_iter);
end
fprintf('\n\n');
x = -5:0.01:0;
y = x.^4 .* 3.^x - 2;
z = x;
phi1 = log(2 ./ x.^4) ./ log(3);
phi2 = (2 .* 3.^-x).^0.25;
dphi = -log(3) ./ ((2 .* 8.^0.25) .* 3 .^0.25 .* x);
h1 = figure();
plot(x,y,x,z,x,phi1,x,phi2);
grid on;
legend("F(x)", "y = x", "Phi1(x)", "Phi2(x)");
h2 = figure();
y1 = 0 .*x +1;
plot(x,dphi,x,y1);
grid on;
legend("Phi'(x)");

b = -5;
q = -log(3) ./ ((2 .* 8.^0.25) .* 3 .^0.25 .* b);
x0 = 0;
counter = 0;

eps = 10 .^ (-4)
cont = true;



printf("\n\n\nЗадание 1:\n");
printf("Номер итерации: | Корень:  | Разность: | Tочность: \n")
while cont
    counter++;
    x0last = x0;
    x0 = (2 .* 3.^-x0).^0.25;
    if abs(x0 - x0last) <= (1-q)./q .* eps
        cont = false;
    endif;
    printf("___________________________________________________");
    printf("\n %-14d | %7f | %9f | %9f \n", counter, x0, abs(x0 - x0last), (1-q)./q .* eps);
end;

h3 = figure();
df = 4 * x.^3 .* 3.^x + log(3) * x.^4 .* 3.^x;
plot(x, df);
legend("df(x)");
m = 4 * 0.^3 .* 3.^0 + log(3) * 0.^4 .* 3.^0;
M = 4 * -5.^3 .* 3.^-5 + log(3) * -5.^4 .* 3.^-5;

eps = 10.^-6;
alpha = 2 ./ (M + m);
nq = (M - m) ./ (M + m);
nx0 = -5;
cont = true;
ncounter = 0;




printf("\n\n\nЗадание 2:\n");
printf("Номер итерации: | Корень:  | Разность: | Tочность: \n");
while cont
    ncounter++;
    nx0last = nx0;
    nx0 = nx0last - alpha .* (nx0last.^4 .* 3.^nx0last - 2);
    if abs(nx0 - nx0last) <= (1-nq)./nq .* eps
        cont = false;
    endif;
    printf("___________________________________________________");
    printf("\n %-14d | %7f | %9f | %9f \n", ncounter, nx0, abs(nx0 - nx0last), (1-nq)./nq .* eps);
end;




printf("\n\n\nЗадание 3:\n");
cont = true;
counter = 0;
X0 = -5;

printf("Номер итерации: | Корень:  | Разность: | Tочность: \n")
while cont
    X0last = X0;
    counter++;

    X0 = X0last - (X0last.^4 .* 3.^X0last - 2) ./ (4 * X0last.^3 .* 3.^X0last + log(3) * X0last.^4 .* 3.^X0last)

    if abs(X0 - X0last) <= eps
        cont = false;
    endif;
    printf("___________________________________________________");
    printf("\n %-14d | %7f | %9f | %9f \n", counter, X0, abs(X0 - X0last), eps);
end;
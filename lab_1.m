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
q = abs(b.*2 + log(2)./(2 .^b))./4
x0 = 0;
counter = 0;

eps = 10 .^ (-4)
cont = true;

printf("\n\n\nЗадание 1:\n");
printf("Номер итерации: | Корень:  | Разность: | Tочность: \n")
while cont
    counter++;
    x0last = x0;
    x0 = (x0 .^2 - 0.5 .^x0 +3)./4;
    if abs(x0 - x0last) <= (1-q)./q .* eps
        cont = false;
    endif;
    printf("___________________________________________________");
    printf("\n %-14d | %7f | %9f | %9f \n", counter, x0, abs(x0 - x0last), (1-q)./q .* eps);
end;

h3 = figure();
df = -log(2)./(2.^x) - 2.^x + 4;
plot(x, df);
legend("df(x)");
m = -log(2)./(2.^ 0.85) - 2.^0.85 + 4;
M = -log(2)./(2.^ 0.65) - 2.^0.65 + 4;

eps = 10.^-6;
alpha = 2 ./ (M + m);
nq = (M - m) ./ (M + m);
nx0 = 0.65;
cont = true;
ncounter = 0;

printf("\n\n\nЗадание 2:\n");
printf("Номер итерации: | Корень:  | Разность: | Tочность: \n");
while cont
    ncounter++;
    nx0last = nx0;
    nx0 = x0last - alpha .* (0.5 .^(x0last) -(x0last-2).^2+1);
    if abs(nx0 - nx0last) <= (1-nq)./nq .* eps
        cont = false;
    endif;
    printf("___________________________________________________");
    printf("\n %-14d | %7f | %9f | %9f \n", ncounter, nx0, abs(nx0 - nx0last), (1-nq)./nq .* eps);
end;

printf("\n\n\nЗадание 3:\n");
cont = true;
counter = 0;
X0 = 0.65;

printf("Номер итерации: | Корень:  | Разность: | Tочность: \n")
while cont
    X0last = X0;
    counter++;
    X0 = X0last - (0.5 .^(X0last) -(X0last-2).^2+1) ./ (-log(2)./(2.^ X0last) - 2.^ X0last + 4);
    if abs(X0 - X0last) <= eps
        cont = false;
    endif;
    printf("___________________________________________________");
    printf("\n %-14d | %7f | %9f | %9f \n", counter, X0, abs(X0 - X0last), eps);
end;

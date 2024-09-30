%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
%システム位置と速度
xi11 = zeros( N, ndata + 1);
xi12 = zeros( N, ndata + 1);
xi13 = zeros( N, ndata + 1);
xi21 = zeros( N, ndata + 1);
xi22 = zeros( N, ndata + 1);
xi23 = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        xi11(i, k)  = X(1, i, k);
        xi12(i, k)  = X(2, i, k);
        xi13(i, k)  = X(3, i, k);
        xi21(i, k)  = X(4, i, k);
        xi22(i, k)  = X(5, i, k);
        xi23(i, k)  = X(6, i, k);
    end
end

figure;
subplot(3, 2, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xi11(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xi11(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x01(1, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{i1,1}[m]');
%title('MAS-Position x');
xlim([-0.5 time]);
ylim([-12 12]);
grid on;

subplot(3, 2, 3);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xi12(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xi12(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x01(2, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{i1,2}[m]');
%title('MAS-Position y');
xlim([-0.5 time]);
ylim([-8 18]);
grid on;

subplot(3, 2, 5);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xi13(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xi13(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x01(3, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x_{i1,3}[m]');
%title('MAS-Position z');
xlim([-0.5 time]);
ylim([-0.5 15]);
grid on;

subplot(3, 2, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xi21(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xi21(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x02(1, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{i2,1}[m/s]');
%title('MAS-Velocity x');
xlim([-0.5 time]);
ylim([-4 6]);
grid on;

subplot(3, 2, 4);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xi22(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xi22(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x02(2, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{i2,2}[m/s]');
%title('MAS-Velocity y');
xlim([-0.5 time]);
ylim([-2 4]);
grid on;

subplot(3, 2, 6);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xi23(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xi23(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x02(3, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x_{i2,3}[m/s]');
%title('MAS-Velocity z');
xlim([-0.5 time]);
ylim([-0.05 0.6]);
grid on;
%%======================================================================

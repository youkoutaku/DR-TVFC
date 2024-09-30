%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
xmax = 0.1;
xmin = -0.01; 

%----local estimation fo reference ----
xv11 = zeros( N, ndata + 1);
xv12 = zeros( N, ndata + 1);
xv13 = zeros( N, ndata + 1);
xv21 = zeros( N, ndata + 1);
xv22 = zeros( N, ndata + 1);
xv23 = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        xv11(i, k)  = xv1(1, i, k);
        xv12(i, k)  = xv1(2, i, k);
        xv13(i, k)  = xv1(3, i, k);
        xv21(i, k)  = xv2(1, i, k);
        xv22(i, k)  = xv2(2, i, k);
        xv23(i, k)  = xv2(3, i, k);
    end
end

figure;
subplot(3, 2, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xv11(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xv11(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x01(1, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x^v_{i1,1}[m]');
%title('MAS-Position x');
xlim([xmin xmax]);
ylim([-12 12]);
grid on;

subplot(3, 2, 3);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xv12(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xv12(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x01(2, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x^v_{i1,2}[m]');
%title('MAS-Position y');
xlim([xmin xmax]);
ylim([-8 18]);
grid on;

subplot(3, 2, 5);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xv13(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xv13(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x01(3, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x^v_{i1,3}[m]');
%title('MAS-Position z');
xlim([xmin xmax]);
ylim([-0.5 15]);
grid on;

subplot(3, 2, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xv21(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xv21(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x02(1, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x^v_{i2,1}[m/s]');
%title('MAS-Velocity x');
xlim([xmin xmax]);
ylim([-2 6]);
grid on;

subplot(3, 2, 4);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xv22(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xv22(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x02(2, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x^v_{i2,2}[m/s]');
%title('MAS-Velocity y');
xlim([xmin xmax]);
ylim([-4 4]);
grid on;

subplot(3, 2, 6);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  xv23(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  xv23(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
plot(t(1:10:ndata),  x02(3, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x^v_{i2,3}[m/s]');
%title('MAS-Velocity z');
xlim([xmin xmax]);
ylim([-0.05 0.6]);
grid on;
%%======================================================================

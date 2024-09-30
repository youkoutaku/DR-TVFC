di1 = zeros( N, ndata + 1);
di2 = zeros( N, ndata + 1);
di3 = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        di1(i, k)  = d(1, i, k);
        di2(i, k)  = d(2, i, k);
        di3(i, k)  = d(3, i, k);
    end
end

di_n = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        di_n(i, k) = norm( d(:, i, k) );
    end
end

figure;
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  d_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  d_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('\|d_{i}\|[m]');
%title('MAS-Position x');
xlim([-0.5 time]);
ylim([-3 3]);
grid on;

figure;
subplot(3, 1, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  di1(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  di1(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{01,1}[m]');
%title('MAS-Position x');
xlim([-0.5 time]);
ylim([-3 3]);
grid on;

subplot(3, 1, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  di2(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  di2(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
    
end
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{01,2}[m]');
%title('MAS-Position y');
xlim([-0.5 time]);
ylim([-3 3]);
grid on;

subplot(3, 1, 3);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  di3(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  di3(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x_{01,3}[m]');
%title('MAS-Position z');
xlim([-0.5 time]);
ylim([-3 3]);
grid on;
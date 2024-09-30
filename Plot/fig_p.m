p3_n = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        p3_n(i, k) = norm( p3(:, i, k) );
    end
end

figure;
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p3_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p3_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('\|p_{3}\|[m]');
%title('MAS-Position x');
xlim([-0.5 time]);
ylim([-3 3]);
grid on;
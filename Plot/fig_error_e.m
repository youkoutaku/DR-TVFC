%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
%推定誤差
ev1_n = zeros( N, ndata + 1);
ev2_n = zeros( N, ndata + 1);
for k = 1:10:ndata/50
    for i = 1:N
        ev1_n(i, k)  = norm(ev1(:, i, k));
        ev2_n(i, k)  = norm(ev2(:, i, k));
    end
end

%position em
figure;
subplot(211)
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata/50), ev1_n(i, 1:10:ndata/50), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata/50), ev1_n(i, 1:10:ndata/50), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
xlim([0 0.1]);
ylim([-0.1 8]);
%xlabel('Time[sec]');
ylabel('||\epsilon^v_{i1}||_2[m]');
grid on;

subplot(212)
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata/50), ev2_n(i, 1:10:ndata/50), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata/50), ev2_n(i, 1:10:ndata/50), '--', 'LineWidth', 2);
    end
end
hold off;
legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
xlim([0 0.1]);
ylim([-0.01 0.4]);
xlabel('Time[s]');
ylabel('||\epsilon^v_{i2}||_2[m/s]');
grid on;
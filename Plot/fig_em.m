%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%======================================================================
%システム編隊追従誤差修正
em1_n = zeros( N, ndata + 1);
em2_n = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        em1_n(i, k)  = norm(emi1(:, i, k));
        em2_n(i, k)  = norm(emi2(:, i, k));
    end
end

figure;
subplot(2, 1, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), em1_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), em1_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
%xlabel('Time[s]');
ylabel('||em_{i1}||_2[m]');
%title('MAS-Position Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

subplot(2, 1, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), em2_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), em2_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
xlabel('Time[s]');
ylabel('||em_{i2}||_2[m/s]');
%title('MAS-Velocity Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

%%----------------------------------------------------------------



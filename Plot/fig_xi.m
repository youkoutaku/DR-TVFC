%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
%誤差修正関数
xi_n  = zeros( N, ndata + 1);
d_xi_n  = zeros( N, ndata + 1);
dd_xi_n  = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        xi_n(i, k)   = norm(xi(:, i, k));
        d_xi_n(i, k) = norm(d_xi(:, i, k));
        dd_xi_n(i, k)= norm(dd_xi(:, i, k));
    end
end

figure;
subplot(3, 1, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), xi_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), xi_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
%xlabel('Time[s]');
ylabel('||{\xi}_{i}||_2[m]');
%title('MAS-Position Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

subplot(3, 1, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), d_xi_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), d_xi_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
%xlabel('Time[s]');
ylabel('||\xi_{i2}||_2[m]');
%title('MAS-Position Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

subplot(3, 1, 3);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), dd_xi_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), dd_xi_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
%xlabel('Time[s]');
ylabel('||{\xi}_{i3}||_2[m]');
%title('MAS-Position Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

%%======================================================================
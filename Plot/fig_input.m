%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%制御入力u
ui_n  = zeros( N, ndata + 1);
ur_n  = zeros( N, ndata + 1);
un_n  = zeros( N, ndata + 1);
ua_n  = zeros( N, ndata + 1);
uN_n  = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        ui_n(i, k)  = norm(u(:, i, k));
    end
end

figure;
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), ui_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), ui_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
xlabel('Time[s]');
ylabel('||u_i||_2[m/s^2]');
%title('MAS-Input');
xlim([-0.1 time]);
%ylim([0 12]);
grid on;
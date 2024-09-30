%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
uv1_n = zeros( N, ndata + 1);
uv2_n = zeros( N, ndata + 1);
for k = 1:10:ndata/50
    for i = 1:N
        uv1_n(i, k)  = norm(uv1(:, i, k));
        uv2_n(i, k)  = norm(uv2(:, i, k));
    end
end

figure;
subplot(2, 1, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata/50), uv1_n(i, 1:10:ndata/50), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata/50), uv1_n(i, 1:10:ndata/50), '--', 'LineWidth', 2);
    end
end
hold off;
xlabel('Time[s]');
ylabel('||u_{1i}^v||_2[m/s^2]');
%title('MAS-Input');
xlim([0 0.1]);
%ylim([0 12]);
grid on;

subplot(2, 1, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata/50), uv2_n(i, 1:10:ndata/50), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata/50), uv2_n(i, 1:10:ndata/50), '--', 'LineWidth', 2);
    end
end
hold off;
legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
xlabel('Time[s]');
ylabel('||u_{2i}^v||_2[m/s^2]');
%title('MAS-Input');
xlim([0 0.1]);
%ylim([0 12]);
grid on;
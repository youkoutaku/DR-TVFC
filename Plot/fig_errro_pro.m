%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
e1_n  = zeros( N, ndata + 1);
e2_n  = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        e1_n(i, k)  = norm(ei1(:, i, k));
        e2_n(i, k)  = norm(ei2(:, i, k));
    end
end



%システム編隊追従誤差
figure;
subplot(2, 1, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), e1_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), e1_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
ylabel('||e_{i1}||_2[m]');
%title('MAS-Position Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

% %小さいグラフ描画
axes('Position', [0.2, 0.6, 0.2, 0.2]);
% グラフの左下の座標と横幅・縦幅を指定
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), e1_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), e1_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
axis([3 10 0 0.5])
%描画範囲を指定
set(gca, 'Ytick', 0:0.5:1)
grid on;

subplot(2, 1, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), e2_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), e2_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10');
xlabel('Time[s]');
ylabel('||e_{i2}||_2[m/s]');
%title('MAS-Velocity Error');
xlim([-0.1 time]);
%ylim([-0.1 4]);
grid on;

% %小さいグラフ描画
axes('Position', [0.1, 0.3, 0.2, 0.2]);
% グラフの左下の座標と横幅・縦幅を指定
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata), e2_n(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata), e2_n(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
axis([3 10 0 0.5])
%描画範囲を指定
set(gca, 'Ytick', 0:0.5:1)
grid on;


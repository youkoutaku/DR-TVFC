%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
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
%システムの移動グラフ
h = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
T3D = 10;
hold on;
for i = 1:N
    if i < 6
        plot3(xi11(i, 1:T3D:ndata), xi12(i, 1:T3D:ndata), xi13(i, 1:T3D:ndata), '-^', 'LineWidth', 2, 'MarkerIndices',1:50*T3D:ndata, 'Markersize', 10);
    else
        plot3(xi11(i, 1:T3D:ndata), xi12(i, 1:T3D:ndata), xi13(i, 1:T3D:ndata), '--square', 'LineWidth', 2, 'MarkerIndices',1:50*T3D:ndata, 'Markersize', 10);
    end
end
plot3(x01(1, 1:T3D:ndata), x01(2, 1:T3D:ndata), x01(3, 1:T3D:ndata), 'k-o','LineWidth', 2, 'MarkerIndices', 1:50*T3D:ndata, 'Markersize', 10);
hold off;
legend('Agent-1', 'Agent-2', 'Agent-3', 'Agent-4', 'Agent-5', 'Agent-6', 'Agent-7', 'Agent-8', 'Agent-9', 'Agent-10', 'Leader');
xlabel('x[m]');
ylabel('y[m]');
zlabel('z[m]');
%title('MAS-Motion');
axis([-15 20 -15 20 0 16]);
%%======================================================================

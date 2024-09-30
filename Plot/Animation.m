%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/08/02 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
%%=                         Graph
%%======================================================================
mycolor = [0 0.4470 0.7410;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880;0 0.4470 0.7410;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880];

h = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
T3D = 10;
axis([-15 20 -15 20 0 16]);
hold on;
xlabel('x[m]');
ylabel('y[m]');
zlabel('z[m]');
grid on;
%plot save object
handles = [[],[]];
for k = 1:10*T3D:ndata
    view(-12.7, 47.3);
    
    %delat the past frame
    if k > 10*T3D
        delete(handles(:,k-10*T3D)); % 前のフレームで描画した点を削除
    end
    
    % Draw the new frame
    handles(1,k) = plot3(xi11(1, k), xi12(1, k), xi13(1, k), '^','LineWidth', 3, 'MarkerSize', 10, 'Color', [0 0.4470 0.7410]);
    handles(2,k) = plot3(xi11(2, k), xi12(2, k), xi13(2, k), '^','LineWidth', 3, 'MarkerSize', 10, 'Color', [0.8500 0.3250 0.0980]);
    handles(3,k) = plot3(xi11(3, k), xi12(3, k), xi13(3, k), '^','LineWidth', 3, 'MarkerSize', 10,'Color', [0.9290 0.6940 0.1250]);
    handles(4,k) = plot3(xi11(4, k), xi12(4, k), xi13(4, k), '^','LineWidth', 3, 'MarkerSize', 10,'Color', [0.4940 0.1840 0.5560]);
    handles(5,k) = plot3(xi11(5, k), xi12(5, k), xi13(5, k), '^','LineWidth', 3, 'MarkerSize', 10,'Color', [0.4660 0.6740 0.1880]);
    handles(6,k) = plot3(xi11(6, k), xi12(6, k), xi13(6, k), 'square','LineWidth', 3, 'MarkerSize', 10,'Color',[0 0.4470 0.7410]);
    handles(7,k) = plot3(xi11(7, k), xi12(7, k), xi13(7, k), 'square','LineWidth', 3, 'MarkerSize', 10,'Color', [0.8500 0.3250 0.0980]);
    handles(8,k) = plot3(xi11(8, k), xi12(8, k), xi13(8, k), 'square','LineWidth', 3, 'MarkerSize', 10,'Color', [0.9290 0.6940 0.1250]);
    handles(9,k) = plot3(xi11(9, k), xi12(9, k), xi13(9, k), 'square','LineWidth', 3, 'MarkerSize', 10,'Color', [0.4940 0.1840 0.5560]);
    handles(10,k) = plot3(xi11(10, k), xi12(10, k), xi13(10, k), 'square','LineWidth', 3, 'MarkerSize', 10,'Color', [0.4660 0.6740 0.1880]);
    handles(11,k) = plot3(x01(1, k), x01(2, k), x01(3, k), 'ko','LineWidth', 3, 'MarkerSize', 10);
    
    % Draw the point 
    for i = 1:N
        plot3(xi11(i, k), xi12(i, k), xi13(i, k), '.', 'LineWidth', 2, 'Color', mycolor(i,:));
    end
    plot3(x01(1, k), x01(2, k), x01(3, k), 'k.', 'LineWidth', 2);
    drawnow;
    pause(0.02);
end
hold off;

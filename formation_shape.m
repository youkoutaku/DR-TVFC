%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%%======================================================================
%%=                 Formation shape
%%======================================================================
%========================================%
%               Initial formation shape
%========================================%
%formation position
p1 = zeros(n, N, ndata + 1);
%formation velocity
p2 = zeros(n, N, ndata + 1);
%formation acceleration
p3 = zeros(n, N, ndata + 1);
%distance
%2^(1/2);
Rp = 2*2^(1/2);

%Relation position
for k = 1:2
    p1(:, 1, k) = 0.5 * Rp * [cos(-pi / 4); sin(- pi / 4); 0];
    p1(:, 2, k) = 1 * Rp * [cos(-pi / 4); sin(- pi / 4); 0];
    p1(:, 3, k) = 1.5 * Rp * [cos(-pi / 4); sin(- pi / 4); 0];
    p1(:, 4, k) = 2 * Rp * [cos(-pi / 4); sin(- pi / 4); 0];
    p1(:, 5, k) = 2.5 * Rp * [cos(-pi / 4); sin(- pi / 4); 0];
    p1(:, 6, k) = 0.5* Rp * [cos(-pi * 3/4); sin(- pi * 3/4); 0];
    p1(:, 7, k) = 1 * Rp * [cos(-pi * 3/4); sin(- pi * 3/4); 0];
    p1(:, 8, k) = 1.5 * Rp * [cos(-pi * 3/4); sin(- pi * 3/4); 0];
    p1(:, 9, k) = 2 * Rp * [cos(-pi * 3/4); sin(- pi * 3/4); 0];
    p1(:,10, k) = 2.5 * Rp * [cos(-pi * 3/4); sin(- pi * 3/4); 0];
end
%========================================%
%           Time-varting Formation
%========================================%
t_c = 10; %formation time
t_t = 10; %Time-varting Time
for k = 2:ndata+1
    if k*SampT <= t_c
        ap = [0; 0; 0];
    elseif t(k) <= (t_c + t_t)
        ap = [0; 0.2 * sin((t(k) - 10) *2* pi / t_t); 0];
    else
        ap = [0; 0; 0];
    end
    
    for i = 1:N
        if i <= 5
            p3(:, i, k) = i * ap;
        else
            p3(:, i, k) = (i - 5) * ap;
        end
    end
    
    p2(:, :, k + 1) = p2(:, :, k) + SampT * p3(:, :, k);
    p1(:, :, k + 1) = p1(:, :, k) + SampT * p2(:, :, k);
end

%========================================%
%           Plot
%========================================%
p11 = zeros( N, ndata + 1);
p12 = zeros( N, ndata + 1);
p13 = zeros( N, ndata + 1);
p21 = zeros( N, ndata + 1);
p22 = zeros( N, ndata + 1);
p23 = zeros( N, ndata + 1);
for k = 1:10:ndata
    for i = 1:N
        p11(i, k)  = p1(1, i, k);
        p12(i, k)  = p1(2, i, k);
        p13(i, k)  = p1(3, i, k);
        p21(i, k)  = p2(1, i, k);
        p22(i, k)  = p2(2, i, k);
        p23(i, k)  = p2(3, i, k);
    end
end

figure;
subplot(3, 2, 1);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p11(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p11(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%xlabel('Time[s]');
ylabel('p_{i1,1}[m]');
%title('MAS-Position x');
xlim([-0.5 time]);
%ylim([-12 12]);
grid on;

subplot(3, 2, 3);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p12(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p12(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;
%xlabel('Time[s]');
ylabel('p_{i1,2}[m]');
%title('MAS-Position y');
xlim([-0.5 time]);
%ylim([-8 18]);
grid on;

subplot(3, 2, 5);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p13(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p13(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;

xlabel('Time[s]');
ylabel('p_{i1,3}[m]');
%title('MAS-Position z');
xlim([-0.5 time]);
%ylim([-0.5 15]);
grid on;

subplot(3, 2, 2);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p21(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p21(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;

%xlabel('Time[s]');
ylabel('p_{i2,1}[m/s]');
%title('MAS-Velocity x');
xlim([-0.5 time]);
%ylim([-4 6]);
grid on;

subplot(3, 2, 4);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p22(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p22(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;

%xlabel('Time[s]');
ylabel('p_{i2,2}[m/s]');
%title('MAS-Velocity y');
xlim([-0.5 time]);
%ylim([-2 4]);
grid on;

subplot(3, 2, 6);
hold on;
for i = 1:10
    if i < 6
        plot(t(1:10:ndata),  p23(i, 1:10:ndata), '-', 'LineWidth', 2);
    else
        plot(t(1:10:ndata),  p23(i, 1:10:ndata), '--', 'LineWidth', 2);
    end
end
hold off;

xlabel('Time[s]');
ylabel('p_{i2,3}[m/s]');
%title('MAS-Velocity z');
xlim([-0.5 time]);
%ylim([-0.05 0.6]);
grid on;
%%======================================================================

%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%======================================================================
%%=              leader states
%%======================================================================
%leader position state
x01 = zeros(n, ndata + 1);
%leader velocity state
x02 = zeros(n, ndata + 1);
%leader acceleration state
u0 = zeros(n, ndata + 1);

k = 1;
omega = zeros(ndata + 1,1);
%max angel velocity of leader path [rad/s]
omega_M = pi / 10;
%Path radius[m]
Rr = 5;
%z - velocity [m/s]
vz = 0.5;
%angular velocity of leader path
omega(k) = omega_M * (1 - exp(k * SampT));
%leader position
x01(1, k) = Rr * (- cos(omega(k) * ((k * SampT))));
x01(2, k) = Rr * sin(omega(k) * ((k * SampT)));
%leader velocity
x02(1, k) = Rr * omega(k) * sin(omega(k) * ((k * SampT)));
x02(2, k) = Rr * omega(k) * cos(omega(k) * ((k * SampT)));
%leader acceleration
u0(1, k) = -Rr * omega(k) ^ 2 * cos(omega(k) * ((k * SampT)));
u0(2, k) = -Rr * omega(k) ^ 2 * sin(omega(k) * ((k * SampT)));
%leader z
u0(3, k)  = vz * (exp(-k*SampT));
x02(3, k) = vz * (1 - exp(-k*SampT) );
x01(3, k) = vz * (k*SampT + exp(-k*SampT) - 1);

for k = 2:ndata+1
    %========================================%
    %           Leader dynamics
    %========================================%
    %angular velocity of leader path
    omega(k) = omega_M * (1 - exp(-t(k)));
    %leader position
    %x01(1, k) = Rr * (1 - cos(omega(k) * ((t(k)))));
    x01(1, k) = Rr * ( -cos(omega(k) * ((t(k)))));
    x01(2, k) = Rr * sin(omega(k) * ((t(k))));
    %leader velocity
    x02(1, k) = Rr * omega(k) * sin(omega(k) * ((t(k))));
    x02(2, k) = Rr * omega(k) * cos(omega(k) * ((t(k))));
    %leader acceleration
    u0(1, k) = -Rr * omega(k) ^ 2 * cos(omega(k) * ((t(k))));
    u0(2, k) = -Rr * omega(k) ^ 2 * sin(omega(k) * ((t(k))));
    %leader z
    u0(3, k) = vz * exp(- (k) * SampT);
    x02(3, k) = vz * (1 - exp(- (k) * SampT));
    x01(3, k) = vz * ((k) * SampT + exp(- (k) * SampT) - 1);
end

%%======================================================================
figure;
subplot(3, 2, 1);
hold on;
plot(t(1:10:ndata),  x01(1, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{01,1}[m]');
%title('MAS-Position x');
xlim([-0.5 time]);
ylim([-12 12]);
grid on;

subplot(3, 2, 3);
hold on;
plot(t(1:10:ndata),  x01(2, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{01,2}[m]');
%title('MAS-Position y');
xlim([-0.5 time]);
ylim([-8 18]);
grid on;

subplot(3, 2, 5);
hold on;
plot(t(1:10:ndata),  x01(3, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x_{01,3}[m]');
%title('MAS-Position z');
xlim([-0.5 time]);
ylim([-0.5 15]);
grid on;

subplot(3, 2, 2);
hold on;
plot(t(1:10:ndata),  x02(1, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{02,1}[m/s]');
%title('MAS-Velocity x');
xlim([-0.5 time]);
ylim([-4 6]);
grid on;

subplot(3, 2, 4);
hold on;
plot(t(1:10:ndata),  x02(2, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('x_{02,2}[m/s]');
%title('MAS-Velocity y');
xlim([-0.5 time]);
ylim([-2 4]);
grid on;

subplot(3, 2, 6);
hold on;
plot(t(1:10:ndata),  x02(3, 1:10:ndata), 'k-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
xlabel('Time[s]');
ylabel('x_{02,3}[m/s]');
%title('MAS-Velocity z');
xlim([-0.5 time]);
ylim([-0.05 0.6]);
grid on;
%%======================================================================

u0_n = zeros(ndata + 1);

for k = 1:10:ndata
    for i = 1:N
        u0_n(k) = norm( u0(:, k) );
    end
end

figure;
hold on;
plot(t(1:10:ndata),  u0_n(1:10:ndata), '-', 'LineWidth', 2);
hold off;
%legend('Agent-1','Agent-2','Agent-3','Agent-4','Agent-5','Agent-6','Agent-7','Agent-8','Agent-9','Agent-10');
%xlabel('Time[s]');
ylabel('\|u_0\|');
%title('MAS-Position x');
xlim([-0.5 time]);
ylim([-3 3]);
grid on;
%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%========================================%
%           System Discretization
%========================================%
%system position state
xi1 = zeros(n, N, ndata + 1);
%system velocity state
xi2 = zeros(n, N, ndata + 1);
%system input
u = zeros(n, N, ndata + 1);
%system state
X = [xi1; xi2];
%system output
Y = [xi1; xi2];
%========================================%
%           System error
%========================================%
%system position error
ei1 = zeros(n, N, ndata + 1);
%system velocity error
ei2 = zeros(n, N, ndata + 1);
%========================================%
%           Disturbance Define
%========================================%
% system disturbance
d = zeros(n, N, ndata + 1);
%========================================%
%           State-estimator Define
%========================================%
%globle estimation of reference position
xv1 = zeros(n, N, ndata + 1);
%globle estimation of reference veocity
xv2 = zeros(n, N, ndata + 1);
%----input of estimator ----
uv1 = zeros(n, N, ndata + 1);
uv2 = zeros(n, N, ndata + 1);
%leader postion info
r1 = zeros(n, ndata + 1);
%leader veocity info
r2 = zeros(n, ndata + 1);
%========================================%
%           modification of error
%========================================%
emi1 = zeros(n, N, ndata + 1);
emi2 = zeros(n, N, ndata + 1);
xi   = zeros(n, N, ndata + 1);
d_xi = zeros(n, N, ndata + 1);
dd_xi= zeros(n, N, ndata + 1);
%========================================%
%           SMFC Define
%========================================%
%Sliding variable
s  = zeros(n, N, ndata + 1);
%inpur fo nominal control
un = zeros(n, N, ndata + 1);
%input of robust control
ur = zeros(n, N, ndata + 1);
%input of modificatory error
um = zeros(n, N, ndata + 1);
%smooth functon
Delta   = zeros(n, N, ndata + 1);
Delta_1 = zeros(n, N, ndata + 1);
Delta_2 = zeros(n, N, ndata + 1);
%========================================%
%           System initial k=1
%========================================%
k = 1;

xi1(:, 1, 1) = x01(:, 1) - 5 * [ rand; -rand; 0];
xi1(:, 2, 1) = x01(:, 1) - 5 * [ rand; -rand; 0];
xi1(:, 3, 1) = x01(:, 1) - 5 * [ rand; -rand; 0];
xi1(:, 4, 1) = x01(:, 1) - 5 * [ rand; rand; 0];
xi1(:, 5, 1) = x01(:, 1) - 5 * [ rand; rand; 0];
xi1(:, 6, 1) = x01(:, 1) - 5 * [-rand; rand; 0];
xi1(:, 7, 1) = x01(:, 1) - 5 * [-rand; rand; 0];
xi1(:, 8, 1) = x01(:, 1) - 5 * [-rand; rand; 0];
xi1(:, 9, 1) = x01(:, 1) - 5 * [ rand; rand; 0];
xi1(:,10, 1) = x01(:, 1) - 5 *  [ rand; rand; 0];

xv1(:, :, 1) =  xi1(:, :, 1);
xv2(:, :, 1) =  xi2(:, :, 1);
%communication information
r1(:, k) = x01(:, k);
r2(:, k) = x02(:, k);

%estmition inital
xv1(:, :, 1) =  xi1(:, :, 1);
for i = 1:N
    xv2(:, i, 1) =  xi2(:, i, 1) + [0.1; 0.1; 0.1];
end
%=======================================velocity
%estimation velocity error
ev2(:, :, k) = xv2(:, :, k) - r2(:, k);
%local estimation velocity error for leader
evs2(:, :, k) = (xv2(:, :, k) - r2(:, k)) * C_B;
for i = 1:N
    %local estimation error for neighbors
    for K = 1:N
        evs2(:, i, k) = evs2(:, i, k) + C_A(i, K) * (xv2(:, i, k) - xv2(:, K, k));
    end
    %smooth functon
    for j = 1:n
        Delta_2(j, i, k) = evs2(j, i, k) / (abs(evs2(j, i, k)) + sigma(i));
    end
    %virtual input
    for in = 1:n
        uv2(in, i, k) = -lva(2) * evs2(in, i, k) - lvb(2) * Delta_2(in, i, k);
    end
    %update estimation
    xv2(:, i, k+1) = xv2(:, i, k) + SampT * uv2(:, i, k);
end
%=======================================Position
%estimation velocity error
ev1(:, :, k) = xv1(:, :, k) - r1(:, k);
%local estimation velocity error for leader
evs1(:, :, k) = (xv1(:, :, k)- r1(:, k)) * C_B;
for i = 1:N
    %local estimation error for neighbors
    for K = 1:N
        evs1(:, i, k) = evs1(:, i, k) + C_A(i, K) * (xv1(:, i, k) - xv1(:, K, k));
    end
    %smooth functon
    for j = 1:n
        Delta_1(j, i, k) = evs1(j, i, k) / (abs(evs1(j, i, k)) + sigma(i));
    end
    %virtual input
    for in = 1:n
        uv1(in, i, k) = -lva(1) * evs1(in, i, k) - lvb(1) * Delta_1(in, i, k) * abs(evs1(in, i, k)) ^ (alpha) + xv2(in, i, k);
    end
    %update estimation
    xv1(:, i, k+1) = xv1(:, i, k) + SampT * uv1(:, i, k);
end
%system states
X(1:3, :, k) = xi1(:, :, k);
X(4:6, :, k) = xi2(:, :, k);
%output
Y(:, :, k) = Co * X(:, :, k) + Do * (u(:, :, k) + d(:, :, k));
%error
ei1(:, i, k) = Y(1:3, i, k) - xv1(:, i, k) - p1(:, i, k);
ei2(:, i, k) = Y(4:6, i, k) - xv2(:, i, k) - p2(:, i, k);
%update states
X(:, :, k+1) = X(:, :, k) + SampT * (Ao * X(:, :, k) + Bo * (u(:, :, k) + d(:, :, k)));

%%======================================================================
%%=                         Simulation
%%======================================================================
for k = 2:ndata+1
    %========================================%
    %           Distribute
    %========================================%
    for i = 1:N
        d(1, i, k) = ad(i) * sin( bd(i) * X(1, i, k) + X(4, i, k)) + ad(i) * cos( bd(i) * X(1, i, k) + X(4, i, k));
        d(2, i, k) = ad(i) * sin( bd(i) * X(2, i, k) + X(5, i, k)) + ad(i) * cos( bd(i) * X(2, i, k) + X(5, i, k));
        d(3, i, k) = ad(i) * sin( bd(i) * X(3, i, k) + X(6, i, k)) + ad(i) * cos( bd(i) * X(3, i, k) + X(6, i, k));
    end
    %========================================%
    %           Estimator
    %========================================%
    %communication information
    r1(:, k) = x01(:, k);
    r2(:, k) = x02(:, k);
    %=======================================velocity
    %estimation velocity error
    ev2(:, :, k) = xv2(:, :, k) - r2(:, k);
    %local estimation velocity error for leader
    evs2(:, :, k) = (xv2(:, :, k) - r2(:, k)) * C_B;
    for i = 1:N
        %local estimation error for neighbors
        for K = 1:N
            evs2(:, i, k) = evs2(:, i, k) + C_A(i, K) * (xv2(:, i, k) - xv2(:, K, k));
        end
        %smooth functon
        for j = 1:n
            Delta_2(j, i, k) = evs2(j, i, k) / (abs(evs2(j, i, k)) + sigma(i));
        end
        %virtual input
        for in = 1:n
            uv2(in, i, k) = -lva(2) * evs2(in, i, k) - lvb(2) * Delta_2(in, i, k);
        end
        %update estimation
        xv2(:, i, k+1) = xv2(:, i, k) + SampT * uv2(:, i, k);
    end
    %=======================================Position
    %estimation velocity error
    ev1(:, :, k) = xv1(:, :, k) - r1(:, k);
    %local estimation velocity error for leader
    evs1(:, :, k) = (xv1(:, :, k)- r1(:, k)) * C_B;
    for i = 1:N
        %local estimation error for neighbors
        for K = 1:N
            evs1(:, i, k) = evs1(:, i, k) + C_A(i, K) * (xv1(:, i, k) - xv1(:, K, k));
        end
        %smooth functon
        for j = 1:n
            Delta_1(j, i, k) = evs1(j, i, k) / (abs(evs1(j, i, k)) + sigma(i));
        end
        %virtual input
        for in = 1:n
            uv1(in, i, k) = -lva(1) * evs1(in, i, k) - lvb(1) * Delta_1(in, i, k) * abs(evs1(in, i, k)) ^ (alpha) + xv2(in, i, k);
        end
        %update estimation
        xv1(:, i, k+1) = xv1(:, i, k) + SampT * uv1(:, i, k);
    end
    %========================================%
    %           Sliding Mode Controller
    %========================================%
    %Y = CX + D(u + d)
    Y(:, :, k) = Co * X(:, :, k) + Do * (u(:, :, k) + d(:, :, k));
    %Fomation tracking error
    ei1(:, :, k) = Y(1:3, :, k) - xv1(:, :, k) - p1(:, :, k);
    ei2(:, :, k) = Y(4:6, :, k) - xv2(:, :, k) - p2(:, :, k);
    if t(k) > Tfv
        %================================================%
        %      Prescried time medification function
        %================================================%
        for i = 1:N
            if t(k) < TF
                d_e = (-2 * lambda(i) * t(k) / (TF - t(k)) - lambda(i) * t(k) ^ 2 / (TF - (t(k))) ^ 2) * exp(-lambda(i) * t(k) ^ 2 / (TF - t(k)));
                dd_e = (-2 * lambda(i) / (TF - (t(k))) - 4 * lambda(i) * (t(k)) / (TF - (t(k))) ^ 2 - 2 * lambda(i) * (t(k)) ^ 2 / (TF - (t(k))) ^ 3) * exp(-lambda(i) * (t(k)) ^ 2 / (TF - (t(k)))) + (-2 * lambda(i) * (t(k)) / (TF - (t(k))) - lambda(i) * (t(k)) ^ 2 / (TF - (t(k))) ^ 2) ^ 2 * exp(-lambda(i) * (t(k)) ^ 2 / (TF - (t(k))));
                xi(:, i, k) = (ei1(:, i, 0.05/SampT) + ei2(:, i, 0.05/SampT) * (t(k))) * exp(-lambda(i) * (t(k)) ^ 2 / (TF - (t(k))));
                d_xi(:, i, k) = (ei1(:, i, 0.05/SampT) + ei2(:, i, 0.05/SampT) * (t(k))) * d_e + (ei2(:, i, 0.05/SampT)) * exp(-lambda(i) * (t(k)) ^ 2 / (TF - (t(k))));
                dd_xi(:, i, k) = (ei2(:, i, 0.05/SampT)) * d_e + (ei1(:, i, 0.05/SampT) + ei2(:, i, 0.05/SampT) * (t(k))) * dd_e + (ei2(:, i, 0.05/SampT)) * d_e;
            else
                xi(:, i, k) = [0; 0; 0];
                d_xi(:, i, k) = [0; 0; 0];
                dd_xi(:, i, k) = [0; 0; 0];
            end
        end
        %========================================%
        %medication of formation error
        emi1(:, :, k) = ei1(:, :, k) - xi(:, :, k);
        emi2(:, :, k) = ei2(:, :, k) - d_xi(:, :, k);
        %Sliding moder variable
        s(:, :, k) = emi1(:, :, k) * diag(c) + emi2(:, :, k);
        %input of medication error
        um(:, :, k) = d_xi(:, :, k) * diag(c) + dd_xi(:, :, k);
        %input of normal control
        un(:, :, k) = - ei2(:, :, k) * diag(c) + um(:, :, k) - s(:, :, k) * diag(ki);
        %smooth funciton
        for i = 1:N
            for j = 1:n
                Delta(j, i, k) = s(j, i, k) / (abs(s(j, i, k)) + sigma(i));
            end
        end
        %input of robust control
        ur(:, :, k) = - Delta(:, :, k) *  diag(eta);
        %Input
        u(:, :, k) = un(:, :, k) + ur(:, :, k);
    end
    %Input limited
    %Umax = 5;
    %for j =1:n
    %    if u(j, i, k) > Umax
    %        u(j, i, k) = Umax;
    %    end
    %    if u(j, i, k) < -Umax
    %        u(j, i, k) = -Umax;
    %    end
    %end
    
    %Update State
    X(:, :, k+1) = X(:, :, k) + SampT * (Ao * X(:, :, k) + Bo * (u(:, :, k) + d(:, :, k)));
    
    %For mistakes
    %X(:, 6, k+1) = X(:, 6, k+1) + SampT * [2; 2; 0; 0; 0; 0];
end
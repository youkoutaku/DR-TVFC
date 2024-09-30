%-------------------------------------------------------------------------------%
%                    Time-varting Formation Control for MAS                     %
%                                                   2024/06/29 by Guang-Ze Yang %
% https://youkoutaku.github.io/                                                 %
%-------------------------------------------------------------------------------%
%========================================%
%           System parameters
%========================================%
%sampling time
SampT = 1e-3;
%simulation time
time = 30;
%number of steps
ndata = time / SampT;
t = SampT:SampT:ndata+1;

%========================================%
%           System Communication
%========================================%
%----Communication Graph----
C_A = [0 0 0 0 0 0 0 0 0 0; %1
    2 0 0 0 0 0 0 0 0 0; %2
    0 2 0 0 0 1 0 0 0 0; %3
    0 0 2 0 0 0 1 0 0 0; %4
    0 0 0 2 0 0 0 0 0 0; %5
    0 0 0 0 0 0 0 0 0 0; %6
    0 0 0 0 0 2 0 0 0 0; %7
    1 0 0 0 0 0 2 0 0 0; %8
    0 1 0 0 0 0 0 2 0 0; %9
    0 0 0 0 0 0 0 0 2 0]; % edge matrix
% binning matrix
C_B = [3 0 0 0 0 0 0 0 0 0; %1
    0 0 0 0 0 0 0 0 0 0; %2
    0 0 0 0 0 0 0 0 0 0; %3
    0 0 0 0 0 0 0 0 0 0; %4
    0 0 0 0 0 0 0 0 0 0; %5
    0 0 0 0 0 3 0 0 0 0; %6
    0 0 0 0 0 0 0 0 0 0; %7
    0 0 0 0 0 0 0 0 0 0; %8
    0 0 0 0 0 0 0 0 0 0; %9
    0 0 0 0 0 0 0 0 0 0];

%%number of agents
N = size(C_A, 1);   % Number of agents
%========================================%
%           System Define
%========================================%
Ao = [0, 0, 0, 1, 0, 0;
    0, 0, 0, 0, 1, 0;
    0, 0, 0, 0, 0, 1;
    0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0; ];
%Satae-space demension
no = size(Ao, 1);
%Space demension
n = no/2;

Bo = [0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    1, 0, 0;
    0, 1, 0;
    0, 0, 1; ];
%input demensions
p = size(Bo, 2);

Co = [1, 0, 0, 0, 0, 0;
    0, 1, 0, 0, 0, 0;
    0, 0, 1, 0, 0, 0;
    0, 0, 0, 1, 0, 0;
    0, 0, 0, 0, 1, 0;
    0, 0, 0, 0, 0, 1];

Do = [0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    0, 0, 0];
%========================================%
%           Disturbance Define
%========================================%
%disturbance parameter
ad = [-1.8, 1.6, 1.9, -1.7, 1.8, -1.6, 1.9, -1.7, 1.5, -1.4];
bd = [-1.3, 0.8, 1.5, -0.6, 0.7, -1.2, 0.9, -0.4, 1.1, -0.5];

%========================================%
%           State-estimator Input
%========================================%
%estimator parameters
alpha = 0.2; %α
%Estimation Gain
lva = [80 80]; %lager
%80 80
lvb = [5 5];
%5 5

%========================================%
%           modification of error
%========================================%
%Estimation time
Tfv = 0.05;

%modification time
TF = 5;

lambda = ones(N,1);

%maximum input
%Umax = 10;
%========================================%
%           Sliding Mode Control
%========================================%
c(1:10) = 1;
%range:1~100. 大きすぎると振幅が大きい
ki(1:10) = [1, 2, 1, 1, 1, 2, 2, 2, 1, 1];
%5
%range:eta > u0_n + p3_n + d_n
eta(1:10) = 7;
%6
%Gain of robust control is more lager, input will more lager and chattering.
%Gain of robust control is more small, input will more small but divergent.

%Smooth functon parameters
sigma(1:10) = 0.01;
%================================================================================%
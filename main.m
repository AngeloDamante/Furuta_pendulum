%%%%% main of project %%%%%

%%% Inizialization of Model
load('workspace_parameters.mat'); %for masses and lengths
x0 = zeros(4, 1);
%x0 = [0 0 pi/20 0];

%%% Run Model
model = 'model/furuta_model.slx';
load_system(model);
sim(model);

%%% Parameters
alpha = ans.p(2);
beta = ans.p(3);
gamma = ans.p(4);
delta = ans.p(5);

%%% Call Script that compute P(S)
FdT;
step(P);  

%%% PID Controller
% Gains computed with PID tuner
Kp = -413;
Kd = -11.3;
Ki = -2960;
C_pid = Kp + Ki*(1/s) + Kd*s; 
W = feedback(C_pid*P, 1);
step(W);

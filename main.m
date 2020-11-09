%%%%% main of project %%%%%

%%% Inizialization of Model
load('workspace_parameters.mat'); %for masses and lengths
x0 = zeros(4, 1);

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
%Gains computed with PID tuner
Kp = -12;
Ki = -12;
C_pid = Kp + Ki*(1/s);

W = feedback(C_pid*P, 1);
step(W);

%%% First controller to mantein theta = 0
first_controller = 'controller/first_controller.slx';
load_system(first_controller);
sim(first_controller);

%%% Swing-Up
x0 = [0 0 pi 0]; %initial position in stable equilibrum point
controller = 'controller/swing_up_controller.slx';
load_system(controller);
sim(controller);



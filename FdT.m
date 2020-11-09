%%%%% Script to compute TF %%%%%

s = tf('s');

%%% Linearization
A_lin = zeros(4);
B_lin = zeros(4, 1);
C_lin = zeros(1, 4);
D_lin = 0;

d = (alpha*beta - gamma^2);

A_lin(1, 2) = 1;
A_lin(2, 2) = (-beta*b_phi)/d;
A_lin(2, 3) = (-gamma*delta)/d;
A_lin(2, 4) = (gamma*b_theta)/d;
A_lin(3, 4) = 1;
A_lin(4, 2) = (gamma*b_phi)/d;
A_lin(4, 3) = (alpha*delta)/d;
A_lin(4, 4) = (-alpha*b_theta)/d;

B_lin(2, 1) = beta/d;
B_lin(4, 1) = -gamma/d;

C_lin(1, 3) = 1;

%%% Transfer Function of Plant
P = zpk(tf(ss(A_lin, B_lin, C_lin, D_lin)));
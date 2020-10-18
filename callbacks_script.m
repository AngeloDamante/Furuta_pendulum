%%% Callbacks PostLoadFcn %%%

m_p = 0.3;  %pendulum mass [kg]
l_p = 0.205;  %pendulum length [m]
m_b = 1;  %brace mass [kg]
l_b = 0.3;  %brace length [m]
M = 1;  %puntiform mass [kg]
J = 0.1531;  %moment of inertia [kg*m^2]
g = 9.81;  %gravity [m*s^-2]

k = 2.7;  %torque drive constant [Nm/V] 
k_i = 2.667;  %drive transconductance constant [A/V]
k_g = 15;  %trasmission ratio
k_t = 0.1;  %torque motor constant [Nm/A]

b_phi = 0.337;  %viscous friction of brace [Nm s/rad]
b_theta = 0.035;  %viscous friction of pendulum [Nm s/rad]
# Furuta Pendulum
Modeling and controller for Furuta Pendulum with <a href ='https://it.mathworks.com/?s_tid=gn_logo'>Simulink, Matlab R2020a and Stateflow</a>.

## Main for complete system
<p align=center>
  <img src="images/full_system.png" />
  <img src="images/code.png" />
</p>

## System description
To compute the mathematical model of the pendulum, we refer to the figure below
<p align=center>
  <img src="images/Furuta_pendulum.jpg" />
</p>

## Parameters of model
The parameters measured in laboratory are:
- pendulum mass m_p = 0.3 kg
- pendulum length l_p = 0.205 m
- brace mass m_b = 1 kg
- brace length l_b = 0.3 m
- puntiform mass M = 1 kg
- inertial moment J = 0.1531 kg*m^2
- gravity g = 9.81 m*s^-2

For constant transduction:
- torque drive constant k = 2.7 Nm/V
- transduction drive constant k_i = 2.667 A/V
- gearbox transmission ratio k_g = 15
- motor torque constant k_t = 0.1 Nm/A

For frictions:
- viscous friction on brace b_phi = 0.337 Nms/rad
- viscous friction on brace p_theta = 0.035 Nms/rad

This parameters are declared in callbacks of simulink model.

## Motion Equations
We use second species Lagrange equations

<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\begin{cases}&space;\frac{d}{dt}\frac{\partial&space;L}{\partial&space;\dot{\varphi}}&space;-&space;\frac{\partial&space;L}{\partial&space;\varphi}&space;=&space;Q_{\varphi}&space;=&space;\tau_{\varphi}&space;-&space;b_{\varphi}\dot{\varphi}\\\frac{d}{dt}\frac{\partial&space;L}{\partial&space;\dot{\vartheta}}&space;-&space;\frac{\partial&space;L}{\partial&space;\vartheta}&space;=&space;Q_{\vartheta}&space;=&space;-&space;b_{\vartheta}\dot{\vartheta}&space;\end{cases}" title="\begin{cases} \frac{d}{dt}\frac{\partial L}{\partial \dot{\varphi}} - \frac{\partial L}{\partial \varphi} = Q_{\varphi} = \tau_{\varphi} - b_{\varphi}\dot{\varphi}\\\frac{d}{dt}\frac{\partial L}{\partial \dot{\vartheta}} - \frac{\partial L}{\partial \vartheta} = Q_{\vartheta} = - b_{\vartheta}\dot{\vartheta} \end{cases}" />

obtain the following dynamic model

<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\begin{cases}&space;(\alpha&space;&plus;&space;\beta&space;s_\vartheta^2)\ddot{\varphi}&space;&plus;&space;\gamma&space;c_\vartheta&space;\ddot{\vartheta}&space;&plus;&space;2&space;\beta&space;s_{\vartheta}&space;c_{\vartheta}\dot{\varphi}&space;\dot{\vartheta}&space;-&space;\gamma&space;s_{\vartheta}\dot{\vartheta}^2&space;=&space;\tau_{\varphi}&space;-&space;b_{\varphi}&space;\dot{\varphi}\\&space;\gamma&space;c_{\vartheta}&space;\ddot{\varphi}&space;&plus;&space;\beta&space;\ddot{\vartheta}&space;-&space;\beta&space;c_{\vartheta}&space;s_{\vartheta}&space;\dot{\varphi}^2&space;-&space;\delta&space;s_{\vartheta}&space;=&space;-&space;b_{\vartheta}&space;\dot{\vartheta}&space;\end{cases}" title="\begin{cases} (\alpha + \beta s_\vartheta^2)\ddot{\varphi} + \gamma c_\vartheta \ddot{\vartheta} + 2 \beta s_{\vartheta} c_{\vartheta}\dot{\varphi} \dot{\vartheta} - \gamma s_{\vartheta}\dot{\vartheta}^2 = \tau_{\varphi} - b_{\varphi} \dot{\varphi}\\ \gamma c_{\vartheta} \ddot{\varphi} + \beta \ddot{\vartheta} - \beta c_{\vartheta} s_{\vartheta} \dot{\varphi}^2 - \delta s_{\vartheta} = - b_{\vartheta} \dot{\vartheta} \end{cases}" />

with

<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\begin{cases}&space;\alpha&space;=&space;J&space;&plus;&space;(M&space;&plus;&space;m_p&space;&plus;&space;\frac{1}{3}m_b)\,l_b^2&space;\\&space;\beta&space;=&space;(M&space;&plus;&space;\frac{1}{3}&space;m_p)\,l_p^2&space;\\&space;\gamma&space;=&space;(M&space;&plus;&space;\frac{1}{\sqrt{3}}m_p)l_b&space;\,&space;l_p&space;\\&space;\delta&space;=&space;(M&space;&plus;&space;\frac{1}{2}m_p)g\,&space;l_p&space;\end{cases}" title="\begin{cases} \alpha = J + (M + m_p + \frac{1}{3}m_b)\,l_b^2 \\ \beta = (M + \frac{1}{3} m_p)\,l_p^2 \\ \gamma = (M + \frac{1}{\sqrt{3}}m_p)l_b \, l_p \\ \delta = (M + \frac{1}{2}m_p)g\, l_p \end{cases}" />

implemented as

<p align=center>
  <img src='images/parameters.png' />
</p>

## Explicit angles
<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\begin{cases}&space;\frac{d}{dt}&space;\dot{\varphi}&space;=&space;\dot\varphi&space;\\&space;\frac{d}{dt}&space;\dot{\varphi}&space;=&space;\frac{\beta\gamma&space;s_{\vartheta}&space;\dot\vartheta^2&space;-&space;\gamma\delta&space;c_{\vartheta}&space;s_{\vartheta}&space;-&space;(2&space;\beta^2&space;c_{\vartheta}&space;s_{\vartheta})\dot\varphi\dot\vartheta&space;&plus;&space;\gamma&space;b_{\vartheta}&space;c_{\vartheta}&space;\dot&space;\vartheta&space;&plus;&space;(\beta&space;\gamma&space;c_{\vartheta}^2&space;s_{\vartheta})&space;\dot&space;\varphi^2&space;&plus;&space;\beta(\tau_\varphi&space;-&space;b_\varphi&space;\dot&space;\varphi)}{\beta(\alpha&space;&plus;&space;\beta&space;s_{\vartheta}^2)-\gamma^2&space;c_{\vartheta}^2}&space;\\&space;\frac{d}{dt}\vartheta&space;=&space;\dot&space;\vartheta&space;\\&space;\frac{d}{dt}&space;\dot&space;\vartheta&space;=&space;\frac{(\alpha&space;&plus;&space;\beta&space;s_\vartheta^2)\delta&space;s_\vartheta&space;&plus;&space;(\alpha&space;&plus;&space;\beta&space;s_\vartheta^2)&space;\beta&space;c_\vartheta&space;s_\vartheta&space;\dot\varphi^2&space;&plus;2&space;\beta\gamma&space;c_\vartheta^2&space;s_\vartheta&space;\dot&space;\varphi&space;\dot\vartheta&space;-\gamma^2&space;s_\vartheta&space;c_\vartheta&space;\dot&space;\vartheta^2&space;-&space;(\alpha&space;&plus;&space;\beta&space;s_\vartheta^2)b_\vartheta&space;\dot&space;\vartheta&space;&plus;&space;\gamma&space;c_\vartheta&space;b_\varphi&space;\dot&space;\varphi&space;-&space;\gamma&space;c_\vartheta&space;\tau_\varphi}{\beta(\alpha&space;&plus;&space;\beta&space;s_\vartheta^2)&space;-&space;\gamma^2&space;c_\vartheta^2}&space;\end{cases}" title="\begin{cases} \frac{d}{dt} \dot{\varphi} = \dot\varphi \\ \frac{d}{dt} \dot{\varphi} = \frac{\beta\gamma s_{\vartheta} \dot\vartheta^2 - \gamma\delta c_{\vartheta} s_{\vartheta} - (2 \beta^2 c_{\vartheta} s_{\vartheta})\dot\varphi\dot\vartheta + \gamma b_{\vartheta} c_{\vartheta} \dot \vartheta + (\beta \gamma c_{\vartheta}^2 s_{\vartheta}) \dot \varphi^2 + \beta(\tau_\varphi - b_\varphi \dot \varphi)}{\beta(\alpha + \beta s_{\vartheta}^2)-\gamma^2 c_{\vartheta}^2} \\ \frac{d}{dt}\vartheta = \dot \vartheta \\ \frac{d}{dt} \dot \vartheta = \frac{(\alpha + \beta s_\vartheta^2)\delta s_\vartheta + (\alpha + \beta s_\vartheta^2) \beta c_\vartheta s_\vartheta \dot\varphi^2 +2 \beta\gamma c_\vartheta^2 s_\vartheta \dot \varphi \dot\vartheta -\gamma^2 s_\vartheta c_\vartheta \dot \vartheta^2 - (\alpha + \beta s_\vartheta^2)b_\vartheta \dot \vartheta + \gamma c_\vartheta b_\varphi \dot \varphi - \gamma c_\vartheta \tau_\varphi}{\beta(\alpha + \beta s_\vartheta^2) - \gamma^2 c_\vartheta^2} \end{cases}" />

the model obtained is

<p align=center>
  <img src="images/model.png" />
</p>

## State Simulation
Use model "furuta_check" to verify the correctness with measurements made in laboratory.

<p align=center>
  <img src="images/sim.png" />
</p>

## Transfer Function
Linearizing around null theta angle, obtain follow function transfer,
<p align=center>
  <img src="https://latex.codecogs.com/gif.latex?\bg_white&space;P(s)&space;=&space;\frac{\theta(s)}{\tau_\varphi&space;(s)}&space;=&space;\frac{\gamma&space;s}{(\gamma^2&space;-&space;\alpha&space;\beta)s^3&space;-&space;(b_\varphi&space;\beta&space;&plus;&space;\alpha&space;b_\vartheta)s^2&space;&plus;&space;(\alpha&space;\delta&space;-&space;b_\vartheta&space;b_\varphi)s&space;&plus;&space;b_\varphi&space;\delta}&space;\notin&space;S" title="P(s) = \frac{\theta(s)}{\tau_\varphi (s)} = \frac{\gamma s}{(\gamma^2 - \alpha \beta)s^3 - (b_\varphi \beta + \alpha b_\vartheta)s^2 + (\alpha \delta - b_\vartheta b_\varphi)s + b_\varphi \delta} \notin S" />
</p>

## PID controller
Utilizing the PID-Tuner obtain follow PID controller

<p align=center>
  <img src="https://latex.codecogs.com/gif.latex?\bg_white&space;(-12)&plus;\frac{(-12)}{s}" title="(-12)+\frac{(-12)}{s}" />
</p>

and the firs controller to mantein null theta angle

<img src="images/first_controller.png" />

## Swing-Up
For Swing-Up problem, the idea has been that of to introduce a wave signal for motor and a control for monitoring theta angle.  

<img src = "images/swing_up_controller.png" />

using stateflow, implement an alternative mode of swing-up controller

<img src = "images/furutaStateflow.png" />
<img src = "images/states.png" />

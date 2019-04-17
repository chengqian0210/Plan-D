%% startVars.m - Initialize variables
% This script initializes variables and buses required for the model to
% work. Mask block parameters are defined by structures that define the
% location of the block, ie. If the Initial Condition parameter is located
% under Vehicle/Nonlinear/Integrator the variable is set to
% Vehicle.Nonlinear.Integrator.initialCondition = 0;

%   Copyright 2013-2017 The MathWorks, Inc.

% Register variables in the workspace before the project is loaded
initVars = who;
% Variants Conditions
asbVariantDefinition;
VSS_COMMAND = 0;       % 0: Signal builder, 1: Joystick, 2: Pre-saved data, 3: Pre-saved data in a Spreadsheet
VSS_SENSORS = 1;       % 0: Feedthrough, 1: Dynamics
VSS_VEHICLE = 1;       % 0: Linear Airframe, 1: Nonlinear Airframe.
VSS_ENVIRONMENT = 0;   % 0: Constant, 1: Variable
VSS_VISUALIZATION = 1; % 0: Scopes, 1: Send values to workspace, 2: FlightGear, 3: Simulink 3D.
VSS_ACTUATORS = 0;     % 0: Feedthrough, 1: Linear Second Order, 2: Noninear Second Order

% Bus definitions 
asbBusDefinitionCommand; 
asbBusDefinitionSensors;
asbBusDefinitionEnvironment;
asbBusDefinitionStates;

% Sampling rate
Ts= 0.01;

% Mass properties
mass = 1.53;
I_x=0.025483;
I_y=0.025504;
I_z=0.00562;
inertia = [I_x 0 0;0 I_y 0;0 0 I_z];
% Initial contitions
initDate = [2019 5 1 0 0 0];
initPosLLA = [37.628738616666666 -1.223933911333333e+02 100];
initPosNED = [0 0 -10];
initVb = [0 0 0];
initEuler = [0 0 0];
initAngRates = [0 0 0];

%% Custom Variables
% Add your variables here:
data1 = load('r_sm.txt');
r_sm_X=data1(:,1);
r_sm_Y=data1(:,2);
%-------------------k_rs插值表-----------------------------------------------------------
data2 = load('k_rs.txt');
k_rs_X=data2(:,1);
k_rs_Y=data2(:,2);
%-------------------k_as插值表-----------------------------------------------------------
data3 = load('k_as_k_ac.txt');
k_as_X=data3(:,1);
k_as_Y=data3(:,2);
%-------------------k_ac插值表-----------------------------------------------------------
k_ac_X=data3(:,1);
k_ac_Y=data3(:,3);
%-------------------k_ra插值表-----------------------------------------------------------
data4 = load('k_ra.txt');
k_ra_X=data4(:,1);
k_ra_Y=data4(:,2);
%-------------------r_m插值表-----------------------------------------------------------
data5 = load('r_m.txt');
r_m_X=data5(:,1);
r_m_Y=data5(:,2);
%-------------------epsilon_m插值表-----------------------------------------------------------
data6 = load('e_m.txt');
e_m_X=data6(:,1);
e_m_Y=data6(:,2);
%-------------------epsilon_p插值表-----------------------------------------------------------
data7 = load('e_p.txt');
e_p_X=data7(:,1);
e_p_Y=data7(:,2);
d2r=pi/180;
r2d=180/pi;
c_m=20*d2r;

addd=0;
addd=1;
mydev=0;
mydev1=0;
mydev2=0;
% myvariable = 0;
a=0;
a=1;
a=2;
a=3;
a=4;
b=0;
% Register variables after the project is loaded and store the variables in
% initVars so they can be cleared later on the project shutdown.
endVars = who;
initVars = setdiff(endVars,initVars);
clear endVars;

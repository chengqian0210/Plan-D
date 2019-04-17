function [sys,x0,str,ts,simStateCompliance] = s_toFM(t,x,u,flag)
%SFUNTMPL General MATLAB S-Function Template
%   With MATLAB S-functions, you can define you own ordinary differential
%   equations (ODEs), discrete system equations, and/or just about
%   any type of algorithm to be used within a Simulink block diagram.
%
%   The general form of an MATLAB S-function syntax is:
%       [SYS,X0,STR,TS,SIMSTATECOMPLIANCE] = SFUNC(T,X,U,FLAG,P1,...,Pn)
%
%   What is returned by SFUNC at a given point in time, T, depends on the
%   value of the FLAG, the current state vector, X, and the current
%   input vector, U.
%
%   FLAG   RESULT             DESCRIPTION
%   -----  ------             --------------------------------------------
%   0      [SIZES,X0,STR,TS]  Initialization, return system sizes in SYS,
%                             initial state in X0, state ordering strings
%                             in STR, and sample times in TS.
%   1      DX                 Return continuous state derivatives in SYS.
%   2      DS                 Update discrete states SYS = X(n+1)
%   3      Y                  Return outputs in SYS.
%   4      TNEXT              Return next time hit for variable step sample
%                             time in SYS.
%   5                         Reserved for future (root finding).
%   9      []                 Termination, perform any cleanup SYS=[].
%
%
%   The state vectors, X and X0 consists of continuous states followed
%   by discrete states.
%
%   Optional parameters, P1,...,Pn can be provided to the S-function and
%   used during any FLAG operation.
%
%   When SFUNC is called with FLAG = 0, the following information
%   should be returned:
%
%      SYS(1) = Number of continuous states.
%      SYS(2) = Number of discrete states.
%      SYS(3) = Number of outputs.
%      SYS(4) = Number of inputs.
%               Any of the first four elements in SYS can be specified
%               as -1 indicating that they are dynamically sized. The
%               actual length for all other flags will be equal to the
%               length of the input, U.
%      SYS(5) = Reserved for root finding. Must be zero.
%      SYS(6) = Direct feedthrough flag (1=yes, 0=no). The s-function
%               has direct feedthrough if U is used during the FLAG=3
%               call. Setting this to 0 is akin to making a promise that
%               U will not be used during FLAG=3. If you break the promise
%               then unpredictable results will occur.
%      SYS(7) = Number of sample times. This is the number of rows in TS.
%
%
%      X0     = Initial state conditions or [] if no states.
%
%      STR    = State ordering strings which is generally specified as [].
%
%      TS     = An m-by-2 matrix containing the sample time
%               (period, offset) information. Where m = number of sample
%               times. The ordering of the sample times must be:
%
%               TS = [0      0,      : Continuous sample time.
%                     0      1,      : Continuous, but fixed in minor step
%                                      sample time.
%                     PERIOD OFFSET, : Discrete sample time where
%                                      PERIOD > 0 & OFFSET < PERIOD.
%                     -2     0];     : Variable step discrete sample time
%                                      where FLAG=4 is used to get time of
%                                      next hit.
%
%               There can be more than one sample time providing
%               they are ordered such that they are monotonically
%               increasing. Only the needed sample times should be
%               specified in TS. When specifying more than one
%               sample time, you must check for sample hits explicitly by
%               seeing if
%                  abs(round((T-OFFSET)/PERIOD) - (T-OFFSET)/PERIOD)
%               is within a specified tolerance, generally 1e-8. This
%               tolerance is dependent upon your model's sampling times
%               and simulation time.
%
%               You can also specify that the sample time of the S-function
%               is inherited from the driving block. For functions which
%               change during minor steps, this is done by
%               specifying SYS(7) = 1 and TS = [-1 0]. For functions which
%               are held during minor steps, this is done by specifying
%               SYS(7) = 1 and TS = [-1 1].
%
%      SIMSTATECOMPLIANCE = Specifices how to handle this block when saving and
%                           restoring the complete simulation state of the
%                           model. The allowed values are: 'DefaultSimState',
%                           'HasNoSimState' or 'DisallowSimState'. If this value
%                           is not speficified, then the block's compliance with
%                           simState feature is set to 'UknownSimState'.


%   Copyright 1990-2010 The MathWorks, Inc.

%
% The following outlines the general structure of an S-function.
%
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 21;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

sys = [];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)
%--------------------------------------------------------------------------------
c1=u(1);
c2=u(2);
c3=u(3);
c4=u(4);
c=[c1;c2;c3;c4];
speed=u(5);
u_=u(6);
v=u(7);
w=u(8);
D_x=u(9);
D_y=u(10);
D_z=u(11);
epsilon_m=u(12);
epsilon_p=u(13);
r_sm=u(14);
k_rs=u(15);
k_as=u(16);
k_ac=u(17);
k_ra=u(18);
r_m=u(19);
beta=u(20);
den=u(21);
%----------------------基本参数---------------------------------------------------
k_TS=9.9796018325697625989171178675552e-6;
k_TV=-2.8620408163265306122448979591837e-4;
d_MS=1.1334291042e-7;
d_ds=-1.3931461486e-5;
c_b=-0.026179938;%漩涡
d_cs=0.0149564;
l_1=0.17078793;
l_2=0.06647954;
k_q0=0.290827;
k_q1=-0.02182;
I_prop=0.000029;
S=0.040828138126052952;%面积
%------------------------------------计算合力F-----------------------------------------------
V_c= -(w-D_z);
T=(k_TS*speed^2-k_TV*(w-D_z)*speed);%推力
ratio=k_q1*V_c+k_q0;%涵道拉力占总拉力比值q
V_i = -(w-D_z)/(2*(1-ratio)) + sqrt( ((w-D_z)/(2*(1-ratio)))^2 + T/(2*den*S*(1-ratio)) )-V_c;%风扇吹出的风速V_c+V_i
Amplitude=sqrt((u_-D_x)^2+(v-D_y)^2+(w-D_z)^2);%来流速度
%------------------------------------------------------------
Coupling=Amplitude/(Amplitude+V_i);%涵道诱导速度与来流耦合因子γ
Coupling_x=sqrt( (u_-D_x)^2 + (w-D_z)^2 ) / (sqrt( (u_-D_x)^2 + (w-D_z)^2 ) + V_i);
Coupling_y=sqrt( (v-D_y)^2 + (w-D_z)^2 ) / (sqrt( (v-D_y)^2 + (w-D_z)^2 ) + V_i);
%==========计算4个舵面衰减因子=============================
%侧风飞行时，涵道内流场会往后压缩，靠近前方来流的舵上受力会减少，远离前方来流的舵上受力会增加

%==================1===================================
if (u_-D_x)<0
    Attenuation1=Constrain(1-k_rs*Coupling_x,1-r_sm,1+r_sm);
elseif (u_-D_x)>=0
    Attenuation1=Constrain(1+k_rs*Coupling_x,1-r_sm,1+r_sm);
end
%===================2==================================
if (v-D_y)<0
    Attenuation2=Constrain(1-k_rs*Coupling_y,1-r_sm,1+r_sm);
elseif (v-D_y)>=0
    Attenuation2=Constrain(1+k_rs*Coupling_y,1-r_sm,1+r_sm);
end
%====================3=================================
if (u_-D_x)<0
    Attenuation3=Constrain(1+k_rs*Coupling_x,1-r_sm,1+r_sm);
elseif (u_-D_x)>=0
    Attenuation3=Constrain(1-k_rs*Coupling_x,1-r_sm,1+r_sm);
end
%====================4=================================
if (v-D_y)<0
    Attenuation4=Constrain(1+k_rs*Coupling_y,1-r_sm,1+r_sm);
elseif (v-D_y)>=0
    Attenuation4=Constrain(1-k_rs*Coupling_y,1-r_sm,1+r_sm);
end
%====================================================
k_cs1=Attenuation1*d_cs;
k_cs2=Attenuation2*d_cs;
k_cs3=Attenuation3*d_cs;
k_cs4=Attenuation4*d_cs;
K_cs=(V_c+V_i)^2*[0    -k_cs2   0   k_cs4;
                  k_cs1   0    -k_cs3   0;
                  0      0    0        0];
F_T=[0;0;-T];%风扇拉力
F_cs=K_cs*(c-[c_b;c_b;c_b;c_b]);%舵面气动力
%==================================

    r_a=k_ra*Coupling;
    if (u_==D_x)&&(v==D_y) 
        k_ax=0;
        k_ay=0;
    else 
        k_ax=k_as*cos(beta);
        k_ay=k_as*sin(beta);
    end
    k_az=-k_ac;
    F_p=r_a*Amplitude^2*[k_ax;k_ay;k_az];%外形气动力
    
    F_m= -r_m*den*S*(V_c+V_i)*[(u_-D_x);(v-D_y);0];%动量阻力
F=F_T+F_cs+F_p+F_m;
%----------------------------合力矩------------------------------------------
%------------从飞机外侧面对舵机转轴往里看，逆时针转为正----------------------------
M_prop=[0;0;d_MS*speed^2];%风扇扭矩+
%======================================================
D_cs=(V_c+V_i)^2*[-k_cs1*l_1          0       k_cs3*l_1         0;
                    0           -k_cs2*l_1       0         k_cs4*l_1;
                  k_cs1*l_2      k_cs2*l_2    k_cs3*l_2    k_cs4*l_2];           
M_cs=D_cs*c;%舵面力矩
%===============================================
M_ds=[0;0;(V_c+V_i)*speed*d_ds];%涵道平衡扭矩-
%============================================
M_gyro=I_prop*speed*[-q;p;0];%陀螺力矩
%=========================================

M_aero= cross(F_p,[0;0;epsilon_p])+cross(F_m,[0;0;epsilon_m]);
M=M_prop+M_cs+M_ds+M_gyro+M_aero;
sys(1)=F;
sys(2)=M;

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate

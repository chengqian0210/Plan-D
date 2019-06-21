%%
d2r=pi/180;
r2d=180/pi;
data=xlsread('DATAfx26Dsnofbturbtest.xlsx');%3679-5492
% data=xlsread('DATAfx19nofbsteptest.xlsx');%3679-5492
roll_e=data(3679:5492,1)./100;
pitch_e=data(3679:5492,2)./100;
yaw_e=data(3679:5492,3)./100;
p_e=data(3679:5492,16)./100;
q_e=data(3679:5492,17)./100;
r_e=data(3679:5492,18)./100;% 实际输出
roll_d=data(3679:5492,4).*d2r/100;
pitch_d=data(3679:5492,5).*d2r/100;
yaw_d=data(3679:5492,6).*d2r/100;% 实际给定控制
roll_eso=data(3679:5492,7)/100;
pitch_eso=data(3679:5492,8)/100;
yaw_eso=data(3679:5492,9)/100;
p_eso=data(3679:5492,10)/100;
q_eso=data(3679:5492,11)/100;
r_eso=data(3679:5492,12)/100;
dx_eso=data(3679:5492,13)/100;
dy_eso=data(3679:5492,14)/100;
dz_eso=data(3679:5492,15)/100;
time=0:0.01:18.13;
% time=0:0.01:10;
%% 角度
figure,
plot(time,roll_d*r2d,'r-');hold on;
plot(time,roll_eso,'b-');hold on;
plot(time,roll_e,'g-');
grid on;
title('滚转角','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
legend('给定','eso','实际输出');
% figure,%% 
% plot(time,pitch_d*r2d,'r-');hold on;
% plot(time,pitch_eso,'b-');hold on;
% plot(time,pitch_e,'g-');grid on;
% title('俯仰角','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\theta (\circ)','FontWeight','bold')
% legend('给定','eso','实际输出');
% 
% figure,%% 
% plot(time,yaw_d*r2d,'r-');hold on;
% plot(time,yaw_eso,'b-');hold on;
% plot(time,yaw_e,'g-');grid on;
% title('偏航角','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\psi (\circ)','FontWeight','bold')
% legend('给定','eso','实际输出');
%% 角速度
%-----------------------------------------------------------------------------------------
figure,%% 
plot(time,p_eso,'b-');hold on;
plot(time,p_e,'g-');grid on;
title('p','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
legend('eso','实际输出');
% figure,%% 
% plot(time,q_eso,'b-');hold on;
% plot(time,q_e,'g-');grid on;
% title('q','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\theta (\circ)','FontWeight','bold')
% legend('eso','实际输出');
% figure,%% 
% plot(time,r_eso,'b-');hold on;
% plot(time,r_e,'g-');grid on;
% title('r','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\psi (\circ)','FontWeight','bold')
% legend('eso','实际输出');

%% 扰动估计
figure,
plot(time,dx_eso*0.0298,'r-');hold on;
title('dx','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
% 
% figure,%% 
% plot(time,dy_eso*0.0298 ,'r-');hold on;
% title('dy','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
% 
% figure,%% 
% plot(time,dz_eso*0.0085,'r-');hold on;
% title('dz','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')

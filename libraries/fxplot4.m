% Ds no turb fb
d2r=pi/180;
r2d=180/pi;
% data=xlsread('DATAfx29Dsfbturbtest.xlsx');%9117-10790
% data=xlsread('DATAfx29Dsfbturbtest.xlsx');%7356-8356
% data=xlsread('DATAfx22Dfbsteptest.xlsx');%7356-8356
data=xlsread('DATAfx13-2_5.xlsx');%7356-8356
roll_e=data(7356:8356,1)./100;
pitch_e=data(7356:8356,2)./100;
yaw_e=data(7356:8356,3)./100;

p_e=data(7356:8356,16)./100;
q_e=data(7356:8356,17)./100;
r_e=data(7356:8356,18)./100;% ʵ�����
roll_d=data(7356:8356,4).*d2r/100;
pitch_d=data(7356:8356,5).*d2r/100;
yaw_d=data(7356:8356,6).*d2r/100;% ʵ�ʸ�������
roll_eso=data(7356:8356,7)/100;
pitch_eso=data(7356:8356,8)/100;
yaw_eso=data(7356:8356,9)/100;

p_eso=data(7356:8356,10)/100;
q_eso=data(7356:8356,11)/100;
r_eso=data(7356:8356,12)/100;
dx_eso=data(7356:8356,13)/100;
dy_eso=data(7356:8356,14)/100;
dz_eso=data(7356:8356,15)/100;
% time=0:0.01:15;
time=0:0.01:10;
%% �Ƕ�
figure,
plot(time,roll_d*r2d,'r-');hold on;
plot(time,roll_eso,'b-');hold on;
plot(time,roll_e,'g-');
grid on;
title('��ת��','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
legend('����','eso','ʵ�����');
% figure,%% 
% plot(time,pitch_d*r2d,'r-');hold on;
% plot(time,pitch_eso,'b-');hold on;
% plot(time,pitch_e,'g-');grid on;
% title('������','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\theta (\circ)','FontWeight','bold')
% legend('����','eso','ʵ�����');
% 
% figure,%% 
% plot(time,yaw_d*r2d,'r-');hold on;
% plot(time,yaw_eso,'b-');hold on;
% plot(time,yaw_e,'g-');grid on;
% title('ƫ����','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\psi (\circ)','FontWeight','bold')
% legend('����','eso','ʵ�����');
%% ���ٶ�
%-----------------------------------------------------------------------------------------
figure,%% 
plot(time,p_eso,'b-');hold on;
plot(time,p_e,'g-');grid on;
title('p','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
legend('eso','ʵ�����');
% figure,%% 
% plot(time,q_eso,'b-');hold on;
% plot(time,q_e,'g-');grid on;
% title('q','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\theta (\circ)','FontWeight','bold')
% legend('eso','ʵ�����');
% figure,%% 
% plot(time,r_eso,'b-');hold on;
% plot(time,r_e,'g-');grid on;
% title('r','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\psi (\circ)','FontWeight','bold')
% legend('eso','ʵ�����');

%% �Ŷ�����
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

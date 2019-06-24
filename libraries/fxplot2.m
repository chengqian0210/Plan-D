
d2r=pi/180;
r2d=180/pi;
data=xlsread('fx4Ds.xlsx');%4292-5792
% data=xlsread('DATAfx20fbsteptest.xlsx');%4292-5792
roll_e=data(4292:5792,1)./100;
pitch_e=data(4292:5792,2)./100;
yaw_e=data(4292:5792,3)./100;
p_e=data(4292:5792,16)./100;
q_e=data(4292:5792,17)./100;
r_e=data(4292:5792,18)./100;% ʵ�����
roll_d=data(4292:5792,4).*d2r/100;
pitch_d=data(4292:5792,5).*d2r/100;
yaw_d=data(4292:5792,6).*d2r/100;% ʵ�ʸ�������
roll_eso=data(4292:5792,7)/100;
pitch_eso=data(4292:5792,8)/100;
yaw_eso=data(4292:5792,9)/100;
p_eso=data(4292:5792,10)/100;
q_eso=data(4292:5792,11)/100;
r_eso=data(4292:5792,12)/100;
dx_eso=data(4292:5792,13)/100;
dy_eso=data(4292:5792,14)/100;
dz_eso=data(4292:5792,15)/100;
% time=0:0.01:28.49;
time=0:0.01:15;
%% �Ƕ�
% figure,
% plot(time,roll_d*r2d,'r-');hold on;
% plot(time,roll_eso,'b-');hold on;
plot(time,roll_e,'b-');
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

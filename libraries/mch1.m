% һ��ʵ�ʷ������롢�����Ŷ���D_s�Ŷ����ƺͷ�����ʵ�Ŷ��Աȣ����������ʵ������Աȣ��޲��
% ���������롢�����Ŷ������Ŷ�������D�Ͳ�����D_s��Ӧ
% ����ͬʱ����Ծ���룬�����Ŷ������Ŷ�������D�Ͳ�����D_s��Ӧ
%==============һ��ʵ�ʷ������롢�����Ŷ�81===============================
% -----------------------------------------------
Roll_d_1=roll_d.Data;
Yaw_d_1=yaw_d.Data;
Pitch_d_1=pitch_d.Data;
% pid D_s �Ŷ�������D_s
Roll1_1=roll.Data;
Yaw1_1=yaw.Data;
Pitch1_1=pitch.Data;
turb1_1=turbulent.Data;
turb_e1_1=turbulent_e.Data;
% ��ʵ���
%-----------------------------------------------
%==============���������롢�����Ŷ�==============
%-------------------------------------------------
Roll_d_2=roll_d.Data;
Yaw_d_2=yaw_d.Data;
Pitch_d_2=pitch_d.Data;
% pid D ���Ŷ����� D%5 0 4 0
Roll1_2=roll.Data;
Yaw1_2=yaw.Data;
Pitch1_2=pitch.Data;
turb1_2=turbulent.Data;
turb_e1_2=turbulent_e.Data;
% pid D_s �Ŷ����� D_s//6.1 0 4.2 0
Roll2_2=roll.Data;
Yaw2_2=yaw.Data;
Pitch2_2=pitch.Data;
turb2_2=turbulent.Data;
turb_e2_2=turbulent_e.Data;
%-------------------------------------------------------------------
%======= ����ͬʱ����Ծ���룬�����Ŷ�70=================================
% -------------------------------------------
%-------------------------------------------------
Roll_d_3=roll_d.Data;
Yaw_d_3=yaw_d.Data;
Pitch_d_3=pitch_d.Data;
% pid D ���Ŷ����� D
Roll1_3=roll.Data;
Yaw1_3=yaw.Data;%5.5 0 3.5 0
Pitch1_3=pitch.Data;%5 0 4 0
turb1_3=turbulent.Data;
turb_e1_3=turbulent_e.Data;
% pid D_s �Ŷ����� D_s//6.1 0 4.2 0
Roll2_3=roll.Data;
Yaw2_3=yaw.Data;
Pitch2_3=pitch.Data;
turb2_3=turbulent.Data;
turb_e2_3=turbulent_e.Data;
%-------------------------------------------------------------------
d2r=pi/180;
r2d=180/pi;
%=================================================

%========================1====================================================
time=0:0.01:25;
figure,%
subplot(2,1,1);
plot(time,turb1_1(2000:4500,1),'r-');hold on;
plot(time,turb_e1_1(2000:4500,1),'b-.');grid on;
title('�Ŷ�����','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('�Ŷ� (rad/s^2)','FontWeight','bold')
axis([0 25 -6 5]);
legend('\bf{f+d}','\bf{ESO����ֵ}');
subplot(2,1,2);
t=1:100:8000;
plot(time,Roll_d_1(2000:4500)*r2d,'r-');hold on;
plot(time,Roll1_1(2000:4500)*r2d,'Color','b','LineStyle','--','Marker','none','MarkerIndices',t);grid on;
xlabel('t (s)','FontWeight','bold');
ylabel('\phi (\circ)','FontWeight','bold')
title('��ת����Ӧ','FontWeight','bold');
axis([0 25 -12 13]);
legend('\bf{\phi_d}','\bf{\phi}');
%-----------------------2--------------------------------
time=0:0.01:10;
t=1:30:1000;
figure,%
plot(time,Roll_d_2(2800:3800)*r2d,'k-');hold on;
plot(time,Roll1_2(2800:3800)*r2d,'Color','r','LineStyle','--','Marker','none','MarkerIndices',t);hold on;
plot(time,Roll2_2(2800:3800)*r2d,'Color','b','LineStyle','-.','Marker','none','MarkerIndices',t);grid on;
axis([0 10 -7 7]);
title('��������Ӧ','FontWeight','bold');
xlabel('t (s)','FontWeight','bold')
ylabel('\phi (\circ)','FontWeight','bold')%ylabel('\bf{\theta\ (\circ)}','FontWeight','bold')
legend('\bf{\phi_d}','\bf{\phi_1}','\bf{\phi_2}');
%========================3=====================================
time=0:0.01:25;
t1=1:30:2500;
t2=1:30:2500;
t3=1:30:2500;
figure,%
plot(time,Roll_d_3(4950:7450)*r2d,'k-','Marker','none','MarkerIndices',t1);hold on;
plot(time,Roll1_3(4950:7450)*r2d,'Color','r','LineStyle','--','Marker','none','MarkerIndices',t1);hold on;
plot(time,Roll2_3(4950:7450)*r2d,'LineStyle','-.','Color','b','Marker','none','MarkerIndices',t1);hold on;
grid on;
axis([0 2.5 -2 12]);
title('��ת�ǽ�Ծ��Ӧ','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\phi (\circ)','FontWeight','bold')
legend('\bf{\phi_d}','\bf{\phi_1}','\bf{\phi_2}');
figure,%
Yaw3_3=[Yaw2_3(4950:4950+158);(Yaw2_3(4950+159:7450)+30*pi/180)/2];
plot(time,Yaw_d_3(4950:7450)*r2d,'k-','Marker','none','MarkerIndices',t3);hold on;
plot(time,Yaw1_3(4948:7448)*r2d,'Color','r','LineStyle','--','Marker','none','MarkerIndices',t3);hold on;
plot(time,Yaw3_3*r2d,'LineStyle','-.','Color','b','Marker','none','MarkerIndices',t3);hold on;
grid on;
axis([0 2.5 -2 32]);
title('ƫ���ǽ�Ծ��Ӧ','FontWeight','bold');xlabel('t (s)','FontWeight','bold');ylabel('\psi (\circ)','FontWeight','bold')
legend('\bf{\psi_d}','\bf{\psi_1}','\bf{\psi_2}');

% legend('\bf{\phi_d}','\bf{\phi_1}','\bf{\phi_2}','\bf{\psi_d}','\bf{\psi_1}','\bf{\psi_2}');
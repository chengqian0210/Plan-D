function y=nonlinear_eso(a_i,j,r_i)
% a_i��(1-1/n_i, i)�������ϣ�n_i ����ϵͳ�״�
% y=sign(r_i)*|r_i|^(j*a_i-(j-1))
y=sign(r_i)*(abs(r_i))^(j*a_i-(j-1));
end
function [u]=wls_dir_alloc_mch(v1, v2,u)
% (c) mengchaoheng
% Last edited 2019-11
v=v1+v2;
umin=[1;1;1;1]*(-10)*pi/180;
umax=[1;1;1;1]*10*pi/180;
uv = dir_alloc_mch(v, umin, umax); % wls_alloc_mch(v,u);% �ȼ���������������
if(check(uv)) % ����������������ֱ������
    u=uv;
else  % �����ټ����Ŷ�����
    uv1 = dir_alloc_mch(v1, umin, umax); % wls_alloc_mch(v1,u);
    if(check(uv1))  % ���Ŷ������㣬�����ز������㣬��������η���
        umax1=umax-uv1;
        umin1=umin-uv1;
        uv2 = dir_alloc_mch(v2, umin1, umax1);
        u=uv1+uv2;
    else  % �Ŷ�Ҳ�������㣬��ֱ�Ӱ��պ����ؽ��з���
        u=uv;
    end
end

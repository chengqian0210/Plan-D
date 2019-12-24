function [u] = dir_alloc_mch(v, umin, umax)
% (c) mengchaoheng
% Last edited 2019-11
%   min z=c*x   subj. to  A*x (=�� >=�� <=) b
%   x 
% ԭ����
% Performs direct control allocation by solving the LP
%   max z=a   subj. to  Bu = av
%   a,u               umin <= u <= umax
% If a > 1, set u = u/a.
% Note: This function has not been optimized for speed.
%  Inputs:
%  -------
% B     control effectiveness matrix (k x m)
% v     commanded virtual control (k x 1)
% umin  lower position limits (m x 1)
% umax  upper position limits (m x 1)
%  Outputs:
%  -------
% u     optimal control (m x 1)
% a     scaling factor  
%% ������
%   min z=[0 -1]x   subj. to  [B -v]x = 0
%   x                       [I 0;-I 0]x <= [umax; -umin]
%   ���� x=[u; a]
% ��Ӧ��͹�Ż���p139,��Ϊ
%   min z=c*x   subj. to  Aeq*x = beq
%   x                     G*x <= h
% �ϲ�
%   min z=c*x   subj. to  [Aeq; G]*x (=��<=) [beq;h]
%   x                     
% ��֤x>=0������
%   min z=[c -c]*X   subj. to  [Aeq -Aeq;G -G]*X (=��<=) [beq;h]
%    X                                          
% ���� X=[x^+; x^-]
%%
B=[-0.5   0      0.5   0;
    0    -0.5    0     0.5;
    0.25  0.25   0.25  0.25];
Aeq=[B -v];
beq=zeros(3,1);
G=[eye(5);-eye(5)];
h=[umax; 20; -umin; 0];
% ������Թ滮
b=[beq;h];
%% �������Թ滮��׼��
% Convert free variables to positively constrained variables
Ad=[Aeq -Aeq; G -G];
[mad,~]= size(Ad);
% �Ȱ�ǰ������ʽ�Ļ��ҵ���������
B=[Ad(1:3,1:3) zeros(3,mad-3);Ad(4:mad,1:3) eye(mad-3)];
Ad=B\Ad;% ����
% �����ɳڱ�����Ӧ�Ļ�
A=[Ad(1:3,1:10) zeros(3,10); Ad(4:13,1:10) eye(10)];
c=[0 0 0 0 -1 0 0 0 0 1 zeros(1,10)];
basis=[1:3 11:20];
z = 0;
%% Simplex algorithm
%% Iterate through simplex algorithm main loop
% [x,z]=Simplex_loop_mch(basis, A, b, c, z); % ���Թ滮�����η�
%% Initialization
iters=0;
e=0;
[m,n] = size(A);
while ~all(c>=0)                      % 3.~isempty(c(c(N)<0))
%     e = find(c < 0, 1, 'first'); % ������������    % 4. e = N(find(c(N)<0,1))
    for i=1:n
        if(c(i)<0)
            e=i;
            break;
        end
    end
    a_ie=A(:,e);
    ip=a_ie>0;
    delta=1e10*ones(m,1);
    if ~isempty(ip)
        delta(ip)=b(ip)./a_ie(ip);
    end
    [~,L]=min(delta);%ѡ����� ������
%         li = basis(L);    % �����������               
    if delta(L) == 1e10                         
        % disp('System is unbounded!');
        break;  % 11.
    else
        %% Perform pivot operation, exchanging L-row with e-coLumn variabLe
%         [basis,A,b,c,z] = pivot_mch(basis,A,b,c,z,L,e); %�����������г����б任
        % Compute the coefficients of the equation for new basic variabLe x_e.
            b(L) = b(L)/A(L,e);                 
            a_Le=A(L,e);% 4.
            A(L,1:n) = A(L,1:n)./a_Le;            
            % Compute the coefficients of the remaining constraints.
            i=[1:L-1 L+1:m];     %  i = find(B~=li);
            if ~isempty(i)
                b(i) = b(i) - A(i,e)*b(L);                                               
                A(i,1:n) = A(i,1:n) - A(i,e)*A(L,1:n);	
            end
            % Compute the objective function
            z = z - c(1,e).*b(L);                     
            c(1,1:n) = c(1,1:n) - c(1,e) * A(L,1:n);          
            % Compute new sets of basic and nonbasic variabLes.
            % N(find(N==e,1)) = li; 
            basis(L)=e;                 %  B(find(B==li,1)) = e;
    end
    iters = iters + 1;
end
x = zeros(n+m,1);                               % [13,16].
x(basis) = b; 
% ת����
u1=x(1:4)-x(6:9);
if z>1  % �Ŵ��˱������ٻ�ԭ����С��1�����ʾ��Ҫ��С��x�Ѿ���Ȼ����߽�
    u = u1./z;
else
    u=u1;
end
end
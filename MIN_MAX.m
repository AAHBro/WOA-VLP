function [lb,ub,TN] = MIN_MAX(ledPositions,D_est,height)
%Min-max�㷨����õ���Lb��ubǰ����������ͬ��û�����⣬��ΪLED��xyһ�����Ե��¼������xy��������һ����
    X_lb = ledPositions(:,1) - D_est;
%     X_lb = 0;
    X_ub = ledPositions(:,1) + D_est;
    Y_lb = ledPositions(:,2) - D_est;
%     Y_lb = 0;
    Y_ub = ledPositions(:,2) + D_est;
    Z_lb = ledPositions(:,3) - D_est;
%     Z_lb = 0;
    Z_ub = 2;%Z_max��ʾTN�����߶�
X = (X_lb + X_ub) / 2;
Y = (Y_lb + Y_ub) / 2;
Z = (Z_lb + Z_ub) / 2;
%����ֲ�
TN = [X_lb+rand()*X,Y_lb+rand()*Y,Z];
%���ȷֲ�
% TN = [X_lb+rand()*X,Y_lb+rand()*Y,Z];

lb = [X_lb, Y_lb, Z_lb]; % λ������
ub = [X_ub, Y_ub, Z_ub]; % λ������


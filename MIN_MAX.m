function [lb,ub,TN] = MIN_MAX(ledPositions,D_est,height)
%Min-max算法计算得到的Lb和ub前两个数据相同，没有问题，因为LED的xy一样所以导致计算出的xy的上下限一样。
    X_lb = ledPositions(:,1) - D_est;
%     X_lb = 0;
    X_ub = ledPositions(:,1) + D_est;
    Y_lb = ledPositions(:,2) - D_est;
%     Y_lb = 0;
    Y_ub = ledPositions(:,2) + D_est;
    Z_lb = ledPositions(:,3) - D_est;
%     Z_lb = 0;
    Z_ub = 2;%Z_max表示TN的最大高度
X = (X_lb + X_ub) / 2;
Y = (Y_lb + Y_ub) / 2;
Z = (Z_lb + Z_ub) / 2;
%随机分布
TN = [X_lb+rand()*X,Y_lb+rand()*Y,Z];
%均匀分布
% TN = [X_lb+rand()*X,Y_lb+rand()*Y,Z];

lb = [X_lb, Y_lb, Z_lb]; % 位置下限
ub = [X_ub, Y_ub, Z_ub]; % 位置上限


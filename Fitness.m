% for n = 1 : M
%搜索空间和LED位置
function fitness = Fitness(X_rand,TN,D_est)
Cn = sqrt(sum((X_rand-TN).^2,2));%cn代表距离每一个鲸鱼到TN的距离
fitness = (Cn - D_est);%D_est代表TN到led的距离，fitness越小代表鲸鱼距离tn越近
% end
% 鲸鱼优化算法
function [Leader_score,Leader_pos,Convergence_curve,searchSpace_position,Positions,FIRST]=WOA(SearchAgents_no,Max_iter,lb,ub,TN,D_est,ledPositions,dim)

% 折扣因子升级鲸鱼位置----21
r=0.5;

% 初始化领导者的位置向量和得分
Leader_pos=zeros(1,dim);
Leader_score=inf; %对于最大化问题，将其更改为-inf

%初始化搜索代理的位置
Positions=initialization(SearchAgents_no,dim,ub,lb);%30*3

%IWOA计算每一个搜索代理的适应度值
% rand_leader_index = floor(SearchAgents_no*rand()+1);%+1目的保证随机索引的空间位1-30
% searchSpace_position = Positions(rand_leader_index, :);
% X_rand = searchSpace_position;
searchSpace_position = lb + (ub-lb) * rand();
X_rand = searchSpace_position;

Convergence_curve=zeros(1,Max_iter);%1*500 收敛曲线

t=0;% 循环计数器
 %[D_est,ledPositions,height] = CHANEL();
% Main loop
while t<Max_iter
    for i=1:size(Positions,1)%30行数        
        % 返回超出搜索空间边界的搜索代理
        Flag4ub=Positions(i,:)>ub;%将每一行超出搜索空间边界的进行标记
        Flag4lb=Positions(i,:)<lb;%将每一行超出搜索空间边界的进行标记
        %对超出部分进行更新  使其个体范围在范围内
        %因为是随机的所以只要保证位置在范围内即可
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % 计算每个搜索代理的目标函数
        %计算适应度是的相关位置，
        %适应度值的计算应该是TN和当前鲸鱼（所有鲸鱼）的位置，而不是随机鲸鱼的位置，输入有问题，和A>1不一样
        %A>1表示估计全局变量中随机一个鲸鱼的位置。
        if t==1 && i == 1
            fitness=Fitness(X_rand,TN,D_est);
        else
            fitness=Fitness(Positions(i,:),TN,D_est);
        end
        
        % 更新领导
        if fitness<Leader_score % Change this to > for maximization problem
            Leader_score=fitness; % 更新α
            Leader_pos=Positions(i,:);%将每一次迭代时所有的搜索代理的位置保存
        end
    end
    if t==15 
        FIRST(1,:) = Leader_pos;
    end
%     if  t==200
%         FIRST(3,:) = Leader_pos;
%     end
    
    %IWOA
    e = exp(1);
    a = 2/(1+e^(t-Max_iter/2));
%     mean_r1_r2_p = 0;  % 均值
%     sigma_r1_r2_p = 1;  % 标准差

        
    % 更新搜索代理的位置
    for i=1:size(Positions,1)
        r1=rand(); % r1 is a random number in [0,1]
        r2=rand(); % r2 is a random number in [0,1]

         %IWOA
%         r1 = normrnd(mean_r1_r2_p, sigma_r1_r2_p);
%         r2 = normrnd(mean_r1_r2_p, sigma_r1_r2_p);
        
    
        A=2*a*r1-a;  % Eq. (2.3) in the paper
        C=2*r2;      % Eq. (2.4) in the paper
        
        b=1;               %  parameters in Eq. (2.5)
%         l=(a2-1)*rand+1;   %  parameters in Eq. (2.5)
        %IWOA
%         mu_l = -1;
%         sigma_l = 1;  
%         l = normrnd(mu_l, sigma_l);
        l = 2 * rand() - 1;
        
        p = rand();        % p in Eq. (2.6)
        %IWOA
%         p = normrnd(mean_r1_r2_p, sigma_r1_r2_p);
        p1 = rand();
        
        for j=1:size(Positions,2)%size 1，2分别计算行数和列数            
            if p<0.5                    %选择收缩包围机制来更新鲸鱼的位置
                if abs(A)>=1            %随机选择一个搜索代理
                    %floor向负无穷方向取整
                    %随机找到一个搜索代理                    
                    rand_leader_index = floor(SearchAgents_no*rand()+1);%+1目的保证随机索引的空间位1-30
                    X_rand = Positions(rand_leader_index, :);
                    D_X_rand=abs(C*X_rand(j)-Positions(i,j)); % Eq. (2.7)%对每一行的逐个元素进行更新
                    Positions(i,j)=X_rand(j)-A*D_X_rand;      % Eq. (2.8)
                    
                elseif abs(A)<1         %选择一个最佳的解决方案来更新搜索代理的位置
                    D_Leader=abs(C*Leader_pos(j)-Positions(i,j)); % Eq. (2.1)
                    Positions(i,j)=Leader_pos(j)-A*D_Leader;      % Eq. (2.2)
                    
                    %IWOA------18
                    if p1 >= 0.5
%                         mu_B = -10 * pi;
%                         sigma_B = 10 * pi;  
%                         B = normrnd(mu_B, sigma_B);
                        B = (20 * pi * rand() - 10 * pi);
                        F_18 = sind(B)/B;
                        Positions(i,j) = Positions(i,j) + F_18;
                    end                    
                end                
            elseif p>=0.5           %选择螺旋模型来更新鲸鱼的位置
                distance2Leader=abs(Leader_pos(j)-Positions(i,j));
                % Eq. (2.5)
                Positions(i,j)=distance2Leader*exp(b.*l).*cos(l.*2*pi)+Leader_pos(j);                
            end
        end
    end
    distance = sqrt(sum((Leader_pos-TN).^2,2));
    t=t+1;
    Convergence_curve(t)=Leader_score;
    [t Leader_score distance Leader_pos]
end
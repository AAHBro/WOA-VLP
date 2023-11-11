% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim =变量的数量
% Max_iteration = maximum number of generations
% SearchAgents_no = 搜索代理数量
% lb=[lb1,lb2,...,lbn] 其中lb是变量n的下界
% ub=[ub1,ub2,...,ubn] 其中ubn是变量n的上界
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run WOA: [Best_score,Best_pos,WOA_cg_curve]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear all;
close all;
clc;

SearchAgents_no=27; % 搜索代理的数量

Function_name='F1'; % F1 ~ F23可选的测试函数名称(文中表1、2、3)

Max_iteration=300; % 最大迭代数

% 加载所选基准函数的详细信息
% [lb,ub,TN,D_est,ledPositions,dim]=Get_Functions_details(Function_name);
[D_est,ledPositions,height] = CHANEL();
[lb,ub,TN]=MIN_MAX(ledPositions,D_est,height);
dim=3;

[Best_score,Best_pos,WOA_cg_curve,searchSpace_position,Positions,FIRST]=WOA(SearchAgents_no,Max_iteration,lb,ub,TN,D_est,ledPositions,dim);

%绘制搜索空间和鲸鱼位置的优化后的点
space(lb,ub,TN,searchSpace_position,Positions,Best_pos,ledPositions,FIRST);

Accury = sqrt(sum((Best_pos - TN).^2,2));

figure('Position',[400   300   500   350]);

%绘制客观空间
% subplot(1,2,2);
semilogy(WOA_cg_curve,'Color','blue')
title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
legend('WOA')

display(['The TN is : ', num2str(TN)]);
display(['The best solution obtained by WOA is : ', num2str(Best_pos)]);
display(['The searchSpace_position is : ', num2str(searchSpace_position)]);
display(['The Accury is : ', Accury]);
display(['The best optimal value of the objective funciton found by WOA is : ', num2str(Best_score)]);

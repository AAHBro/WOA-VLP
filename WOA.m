% �����Ż��㷨
function [Leader_score,Leader_pos,Convergence_curve,searchSpace_position,Positions,FIRST]=WOA(SearchAgents_no,Max_iter,lb,ub,TN,D_est,ledPositions,dim)

% �ۿ�������������λ��----21
r=0.5;

% ��ʼ���쵼�ߵ�λ�������͵÷�
Leader_pos=zeros(1,dim);
Leader_score=inf; %����������⣬�������Ϊ-inf

%��ʼ�����������λ��
Positions=initialization(SearchAgents_no,dim,ub,lb);%30*3

%IWOA����ÿһ�������������Ӧ��ֵ
% rand_leader_index = floor(SearchAgents_no*rand()+1);%+1Ŀ�ı�֤��������Ŀռ�λ1-30
% searchSpace_position = Positions(rand_leader_index, :);
% X_rand = searchSpace_position;
searchSpace_position = lb + (ub-lb) * rand();
X_rand = searchSpace_position;

Convergence_curve=zeros(1,Max_iter);%1*500 ��������

t=0;% ѭ��������
 %[D_est,ledPositions,height] = CHANEL();
% Main loop
while t<Max_iter
    for i=1:size(Positions,1)%30����        
        % ���س��������ռ�߽����������
        Flag4ub=Positions(i,:)>ub;%��ÿһ�г��������ռ�߽�Ľ��б��
        Flag4lb=Positions(i,:)<lb;%��ÿһ�г��������ռ�߽�Ľ��б��
        %�Գ������ֽ��и���  ʹ����巶Χ�ڷ�Χ��
        %��Ϊ�����������ֻҪ��֤λ���ڷ�Χ�ڼ���
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % ����ÿ�����������Ŀ�꺯��
        %������Ӧ���ǵ����λ�ã�
        %��Ӧ��ֵ�ļ���Ӧ����TN�͵�ǰ���㣨���о��㣩��λ�ã���������������λ�ã����������⣬��A>1��һ��
        %A>1��ʾ����ȫ�ֱ��������һ�������λ�á�
        if t==1 && i == 1
            fitness=Fitness(X_rand,TN,D_est);
        else
            fitness=Fitness(Positions(i,:),TN,D_est);
        end
        
        % �����쵼
        if fitness<Leader_score % Change this to > for maximization problem
            Leader_score=fitness; % ���¦�
            Leader_pos=Positions(i,:);%��ÿһ�ε���ʱ���е����������λ�ñ���
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
%     mean_r1_r2_p = 0;  % ��ֵ
%     sigma_r1_r2_p = 1;  % ��׼��

        
    % �������������λ��
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
        
        for j=1:size(Positions,2)%size 1��2�ֱ��������������            
            if p<0.5                    %ѡ��������Χ���������¾����λ��
                if abs(A)>=1            %���ѡ��һ����������
                    %floor�������ȡ��
                    %����ҵ�һ����������                    
                    rand_leader_index = floor(SearchAgents_no*rand()+1);%+1Ŀ�ı�֤��������Ŀռ�λ1-30
                    X_rand = Positions(rand_leader_index, :);
                    D_X_rand=abs(C*X_rand(j)-Positions(i,j)); % Eq. (2.7)%��ÿһ�е����Ԫ�ؽ��и���
                    Positions(i,j)=X_rand(j)-A*D_X_rand;      % Eq. (2.8)
                    
                elseif abs(A)<1         %ѡ��һ����ѵĽ���������������������λ��
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
            elseif p>=0.5           %ѡ������ģ�������¾����λ��
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
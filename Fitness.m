% for n = 1 : M
%�����ռ��LEDλ��
function fitness = Fitness(X_rand,TN,D_est)
Cn = sqrt(sum((X_rand-TN).^2,2));%cn�������ÿһ�����㵽TN�ľ���
fitness = (Cn - D_est);%D_est����TN��led�ľ��룬fitnessԽС���������tnԽ��
% end
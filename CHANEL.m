function [D_est,ledPositions,height] = CHANEL()
% ����ߴ�
length = 5;   % ���ȣ��ף�
width = 5;   % ��ȣ��ף�
height = 3;   % �߶ȣ��ף�
ledPositions = [length/2, width/2, height;];
%LOS�ŵ�����
%��Ҫ������ǶȺ�����Ƕ�����Ϊ�ɸı�
%-------------------------------------
irradiancee_angle_2 = 0;%��2LED 1��PD����ķ��ߵķ��սǡ���������
incidence_angle_2 = 0;%��2LED 1��PD����ķ��ߵ�����ǡ���������
%�޸ĽǶ�
% irradiancee_angle_2 = 15;%��2LED 1��PD����ķ��ߵķ��սǡ���������
% incidence_angle_2 = 75;%��2LED 1��PD����ķ��ߵ�����ǡ���������
%-------------------------------------
incidence_semi_angle = 60;    %��1/2�������
m = -log10(2)/log(cosd(incidence_semi_angle));     %�ʲ�����
FOV = 80;           %��c��ʾPD���ӳ��Ƕ�
R = 0.53;           %LED����Ӧ��
P_t = 100;          %LED���书��
S = 1 ;             % PD��� 10cm2
n = 1.5;            %��ѧ�۹�����������
T_s = 1 ;           % Ts(��) �˹�Ƭ����
G_s = n^2/sind(FOV)^2; %g(��)��ѧ�۹���������
% M = 1;%led����

%ͨ��IWOA-MIN-MAX�㷨���Ƴ�TN�Ĵ���λ��,�ĸ�LED�ֱ����TN��λ�ã�
d = rand() * 2;               %ͨ�ž���0-2�׹���Ԫ�����������߸���RSS�õ�
% for i = 1:M
%LOS�ŵ����� 
%������û�м��� �Ƕ�����
Omega_0 = (m+1) / (2 * pi) * cosd(incidence_angle_2)^m;
H_0 = S * Omega_0 * T_s * G_s * cosd(irradiancee_angle_2) / d^2;%dΪLED��PD֮��ľ���    
% Pel PD��LOS·���Ͻ��յĵ繦��
P_el = R^2 * P_t^2 * H_0^2;
% Pr���չ��ʰ���LOS�����⡢���Ӿ�(NLOS)�������������;�ͷ���� Ҳ�и�˹��������غ�������ֱ��ʹ��
% ���ò���
sigma = 2;   %����
% ������̬�ֲ������
N_noise = sqrt(sigma^2) * randn();  % ���� 1000 ������ N(0, ��^2) �������
P_r = P_el + N_noise;

%������3D��2D�ӽǵľ���
%3_D��λϵͳLED��TN֮���б�ʾ���
d_est = sqrt(((m+1) * S * cosd(incidence_angle_2)^m * T_s * G_s * cosd(irradiancee_angle_2) * P_t * R / d^2) / (2 * pi* sqrt(P_r)));
sigma_m = 2;   % ����
% ������̬�ֲ������
Nm_noise = sqrt(sigma_m^2) * rand();  % ���� 1000 ������ N(0, ��^2) �������
%3Dʵ�ʲ����ľ��뻹�����ܵ�����������
D_est = d_est + Nm_noise;% ʵ�ʲ�������


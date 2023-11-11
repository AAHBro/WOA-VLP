function [D_est,ledPositions,height] = CHANEL()
% 房间尺寸
length = 5;   % 长度（米）
width = 5;   % 宽度（米）
height = 3;   % 高度（米）
ledPositions = [length/2, width/2, height;];
%LOS信道参数
%需要将辐射角度和入射角度设置为可改变
%-------------------------------------
irradiancee_angle_2 = 0;%φ2LED 1和PD表面的法线的辐照角。假设正对
incidence_angle_2 = 0;%ψ2LED 1和PD表面的法线的入射角。假设正对
%修改角度
% irradiancee_angle_2 = 15;%φ2LED 1和PD表面的法线的辐照角。假设正对
% incidence_angle_2 = 75;%ψ2LED 1和PD表面的法线的入射角。假设正对
%-------------------------------------
incidence_semi_angle = 60;    %φ1/2半入射角
m = -log10(2)/log(cosd(incidence_semi_angle));     %朗伯阶数
FOV = 80;           %ψc表示PD的视场角度
R = 0.53;           %LED的响应度
P_t = 100;          %LED发射功率
S = 1 ;             % PD面积 10cm2
n = 1.5;            %光学聚光器的折射率
T_s = 1 ;           % Ts(ψ) 滤光片增益
G_s = n^2/sind(FOV)^2; %g(ψ)光学聚光器的增益
% M = 1;%led数量

%通过IWOA-MIN-MAX算法估计出TN的大致位置,四个LED分别距离TN的位置；
d = rand() * 2;               %通信距离0-2米惯性元器件得来或者根据RSS得到
% for i = 1:M
%LOS信道增益 
%条件还没有加上 角度限制
Omega_0 = (m+1) / (2 * pi) * cosd(incidence_angle_2)^m;
H_0 = S * Omega_0 * T_s * G_s * cosd(irradiancee_angle_2) / d^2;%d为LED和PD之间的距离    
% Pel PD在LOS路径上接收的电功率
P_el = R^2 * P_t^2 * H_0^2;
% Pr接收功率包含LOS分量外、非视距(NLOS)分量、热噪声和镜头噪声 也有高斯白噪声相关函数可以直接使用
% 设置参数
sigma = 2;   %方差
% 生成正态分布随机数
N_noise = sqrt(sigma^2) * randn();  % 生成 1000 个服从 N(0, σ^2) 的随机数
P_r = P_el + N_noise;

%计算在3D和2D视角的距离
%3_D定位系统LED与TN之间的斜率距离
d_est = sqrt(((m+1) * S * cosd(incidence_angle_2)^m * T_s * G_s * cosd(irradiancee_angle_2) * P_t * R / d^2) / (2 * pi* sqrt(P_r)));
sigma_m = 2;   % 方差
% 生成正态分布随机数
Nm_noise = sqrt(sigma_m^2) * rand();  % 生成 1000 个服从 N(0, σ^2) 的随机数
%3D实际测量的距离还可能受到环境的噪声
D_est = d_est + Nm_noise;% 实际测量距离


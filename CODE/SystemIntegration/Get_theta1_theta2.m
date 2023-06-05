function [angle1,angle2] = Get_theta1_theta2(coordY,coordZ,L)
% This function takes the input coordY,coordZ and gives the output angle1,
% angle2
% The calculation is through the inverse kinematics of a robot type D2 DELTA ROBOT

% Constants
% L1 - upper arm length (equal to L4)
% L2 - lower arm length (equal to L3)
% L5 - distance between motors
% L6 

if nargin < 3 
    L = [120,150,50,60];
end

% L = [L1,L2,L5,L6]
L1 = L(1);  L2 = L(2);  L5 = L(3);  L6 = L(4);

PulPerRev = 400;
% common to both sigmas
A = coordY^2 + coordZ^2 + L1^2 - L2^2 + 0.25*L5^2 + 0.25*L6^2; 
C = -2*coordZ*L1;
  
% sigma1
B_t1 = 2*coordY*L1 + L1*L5 - L1*L6;
D_t1 = coordY*L5 - coordY*L6 - 0.5*L5*L6;
sigma1 = (-B_t1 + sqrt(B_t1^2 - (A - C + D_t1)*(A + C + D_t1))) / (A - C + D_t1);  

% sigma2
B_t2 = -2*coordY*L1 + L1*L5 - L1*L6;
D_t2 = -coordY*L5 + coordY*L6 - 0.5*L5*L6;
sigma2 = (-B_t2 + sqrt(B_t2^2 - (A - C + D_t2)*(A + C + D_t2))) / (A - C + D_t2);  
  
% thetas
theta1 = 2 * atan(sigma1);
theta2 = 2 * atan(sigma2);
  
% converte to DEG
theta1 = theta1 * (180 / pi);
theta2 = theta2 * (180 / pi);
  
% determine pulses to be executed by the motor
angle1 = round(theta1*PulPerRev/360); % 100 * PulPerRev/360 conversão para pulsos com redutora de 100:1
angle2 = round(theta2*PulPerRev/360);
end
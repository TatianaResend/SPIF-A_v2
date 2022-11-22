clc, clear, close all
addpath("Lib\")
figure(1)
grid on
hold on
axis equal

DrawTrapeze (-100,-130,75)

% Arms configuration:
x1=-25;     % x initial arm 1
x2=25;      % x initial arm 2:
L1=100; 
L2=150;
jtypes=[0 0 0];
[P_b, F]=seixos3(3);
colors = 'wbg';
BinM1 = [];
BinM2 = [];

P_x = 0; P_y = -130;

[H_eix1,h_eix1,P_eix1,...
    H_eix2,h_eix2,P_eix2] = InitRobot(P_x,P_y,x1,x2,L1,L2);
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x+25)];
BinM2 = [BinM2 ; abs(P_y) + 3*abs(P_x-25)];


pause(1)
P_x = 100; P_y = -130;
CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2)
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x+25)];
BinM2 = [BinM2 ; abs(P_y) + 3*abs(P_x-25)];


P_x = -100; P_y = -130;
CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2)
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x+25)];
BinM2 = [BinM2 ; abs(P_y) + 3*abs(P_x-25)];

P_x = -61.2; P_y = -230;
CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2)
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x+25)];
BinM2 = [BinM2 ; abs(P_y) + 3*abs(P_x-25)];

P_x = 61.2; P_y = -230;
CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2)
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x+25)];
BinM2 = [BinM2 ; abs(P_y) + 3*abs(P_x-25)];

for i = 1:10
    P_x = randi([-61 61]);
    P_y = randi([-230 -130]);
    CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2)
    BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x+25)];
    BinM2 = [BinM2 ; abs(P_y) + 3*abs(P_x-25)];
end    

BinM12 = [BinM1 BinM2]
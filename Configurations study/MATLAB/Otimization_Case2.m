clc, clear, close all
addpath("Lib\")
figure(1)
grid on
hold on
axis equal

y_AreaWork = -130;
x_AreaWork = -25;
DrawTrapeze (x_AreaWork,y_AreaWork,75)

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

P_x = 75; P_y = y_AreaWork;

[H_eix1,h_eix1,P_eix1,...
    H_eix2,h_eix2,P_eix2] = InitRobot(P_x,P_y,x1,x2,L1,L2);
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x-x1)];
P_y2 = h_eix1.XData(3);
BinM2 = [BinM2 ; abs(P_y2) + 3*abs(P_x-x2)];


pause(1)
P_x = 175; P_y = y_AreaWork;
h_eix1 = CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2);
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x-x1)];
P_y2 = h_eix1.XData(3);
BinM2 = [BinM2 ; abs(P_y2) + 3*abs(P_x-x2)];
%%

P_x = -25; P_y = y_AreaWork;
h_eix1 = CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2);
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x-x1)];
P_y2 = h_eix1.XData(3);
BinM2 = [BinM2 ; abs(P_y2) + 3*abs(P_x-x2)];

P_x = 13.8; P_y = y_AreaWork - 100;
h_eix1 = CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2);
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x-x1)];
P_y2 = h_eix1.XData(3);
BinM2 = [BinM2 ; abs(P_y2) + 3*abs(P_x-x2)];

P_x = 136.2; P_y = y_AreaWork - 100;
h_eix1 = CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2);
BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x-x1)];
P_y2 = h_eix1.XData(3);
BinM2 = [BinM2 ; abs(P_y2) + 3*abs(P_x-x2)];

for i = 1:10
    P_x = randi([14 136]);
    P_y = randi([(y_AreaWork - 100) y_AreaWork]);
    h_eix1 = CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2);
    BinM1 = [BinM1 ; abs(P_y) + 3*abs(P_x-x1)];
    P_y2 = h_eix1.XData(3);
    BinM2 = [BinM2 ; abs(P_y2) + 3*abs(P_x-x2)];
end    

BinM12 = [BinM1 BinM2]
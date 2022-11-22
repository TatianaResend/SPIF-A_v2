function CurrentRobot(P_x,P_y,x1,x2,L1,L2,H_eix1,h_eix1,P_eix1,H_eix2,h_eix2,P_eix2)
P = [P_x,P_y];
P_b1 =[P(1)-25 P(2)+25];
P_b2 =[P(1)+25 P(2)+25];
    
QA_b1 = invkinRR_nOrg(P_b1(1),P_b1(2),x1,0,L1,L2);
QA_b2 = invkinRR_nOrg(P_b2(1),P_b2(2),x2,0,L1,L2);
    
DH_b1=[QA_b1(1,1) x1 0 pi/2
       QA_b1(2,1) L1 0 0
       QA_b1(3,1) L2 0 0];
    
DH_b2=[QA_b2(1,1) x2 0 pi/2
       QA_b2(2,2) L1 0 0
       QA_b2(3,2) L2 0 0];

Update(DH_b1,H_eix1,h_eix1,P_eix1);
Update(DH_b2,H_eix2,h_eix2,P_eix2);

plot3(P(1),0,P(2),'o','markerfacecolor','r','markeredgecolor','r')
view([0 0]); % X-Z
pause(1)
end
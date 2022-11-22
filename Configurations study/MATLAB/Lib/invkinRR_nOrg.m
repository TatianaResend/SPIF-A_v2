function Q = invkinRR_nOrg(x, y, x1, y1, L1, L2)
x = x - x1;
y = y - y1;
Q = zeros(3,2);
teta2 = acos((x^2+y^2-L1^2-L2^2)/(2*L1*L2));
teta1 = atan2(y*(L1+L2*cos(teta2))-x*L2*sin(teta2),x*(L1+L2*cos(teta2))+y*L2*sin(teta2));
teta12 = atan2(y*(L1+L2*cos(-teta2))-x*L2*sin(-teta2),x*(L1+L2*cos(-teta2))+y*L2*sin(-teta2));
%teta3 = 0;

% Q = [teta3;teta1;teta2];
Q(2,1) = teta1;
Q(2,2) = teta12;
Q(3,2) = -1*teta2;
Q(3,1) = teta2;

end
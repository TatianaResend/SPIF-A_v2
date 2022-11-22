function T=trans(x,y,z)

T=eye(4);
T(1,4)=x;
T(2,4)=y;
T(3,4)=z;
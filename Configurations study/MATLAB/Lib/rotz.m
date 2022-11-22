function Rz=rotz(t)      %Rotação pura em Z (3D)

Rz= eye(4);
Rz(1,1) = cos(t);
Rz(1,2) = -sin(t);
Rz(2,1) = sin(t);
Rz(2,2) = cos(t);
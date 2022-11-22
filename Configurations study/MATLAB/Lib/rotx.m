function Rx=rotx(t)      %Rotação pura em X (3D)

Rx= eye(4);
Rx(2,2) = cos(t);
Rx(2,3) = -sin(t);
Rx(3,2) = sin(t);
Rx(3,3) = cos(t);
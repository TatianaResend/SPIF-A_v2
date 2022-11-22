function [P,F]=seixos3(scale)
% Function that returns the homogeneous coordinates of an object to represent a reference frame.
% scale - the scale of the object (default is 1)
% P - The 4xN matrix with vertices of the objects to draw (4 means that the homogeneous coordinate is present)
% F - the list of vertices that make up each face
% 
% The return values can be used in a patch command such as this example:
%   patch('Vertices',P(1:3,:)', 'Faces', F, 'FaceColor', 'y');
%
% V. Santos, LAR-DEMUA, Oct 2007, 2010, 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 1
    scale=1;
end

% Partial definition of each object (X, Y and Z axis)
Xpart = scale*[  %23 vertices
 0  0.05   0.5   0.4  0.5  0.6   0.7  0.75   0.8  0.7   1     1    1.5     1   1     0.7  0.8  0.7  0.6  0.5  0.4  0.5   0.05
 0 -0.05  -0.05 -0.2 -0.2 -0.05 -0.2 -0.2  -0.2 -0.05 -0.05 -0.2    0    0.2   0.05  0.05  0.2  0.2  0.05 0.2  0.2  0.05 0.05
 0    0      0     0    0    0     0     0    0   0     0      0    0      0   0      0      0    0    0   0    0    0    0
 ];

Ypart = scale*[  %16 vertices
0 0.05 0.05 0.2 0.2 0.05 0.05 0.2 0   -0.2  -0.05 -0.05 -0.2 -0.2 -0.05 -0.05
0 0.05 0.6  0.7 0.8 0.7  1    1   1.5  1     1     0.7   0.8  0.7  0.6   0.05
0    0    0    0   0   0    0    0   0    0     0     0     0    0    0     0
 ];

Zpart = scale*[ %21 vertices
     0      0     0      0     0    0    0     0     0     0   0   0   0    0    0   0    0    0    0     0    0 
     0  -0.05 -0.05  -0.2  -0.2 -0.1 -0.1  -0.05 -0.05 -0.2 0   0.2 0.05 0.05 0.2 0.2  0.1  0.1  0.05  0.05 0.05 
     0   0.05  0.55   0.45  0.8  0.8  0.62  0.66  1     1   1.5 1   1    0.7  0.8 0.45 0.45 0.62 0.58  0.5  0.05
]; 
 
% Concatenate the three objects in one matrix
X = [ Xpart(1,:) Ypart(1,:) Zpart(1,:) ];
Y = [ Xpart(2,:) Ypart(2,:) Zpart(2,:) ];
Z = [ Xpart(3,:) Ypart(3,:) Zpart(3,:) ];

%Add homogeneous coordinate to ease calculations
P=[ X; Y; Z; ones(1,size(X,2))];
F=[ 1:23 
    24:39 39*ones(1,7)   %7 dummies to make matrix uniform
    40:60 60*ones(1,2)   %2 dummies to make matrix uniform
  ];

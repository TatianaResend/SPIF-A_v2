function DrawTrapeze (x,y,alf)
% Função para desenhar o trapézio

x1 = x + 200;           y1 = y;
x2 = x + abs(100*sin(alf));    y2 = y - 100;
x3 = x1 - abs(100*sin(alf));   y3 = y1 - 100;
Vertices = [x2 , 0 , y2     
            x3 , 0 , y3      
            x  , 0 , y   
            x1 , 0 , y1];    
Faces = [1 2 4 3];
patch('Vertices',Vertices,'Faces',Faces,'FaceColor','w')

end
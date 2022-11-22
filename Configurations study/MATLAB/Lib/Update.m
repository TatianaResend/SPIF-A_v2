function [H,h,P] = Update(DH,H,h,P)

AA = Tlinks(DH);

% AnimateRobot(H,AA,P,h,sd)
Org=LinkOrigins(AA);
h.XData=Org(1,:);
h.YData=Org(2,:);
h.ZData=Org(3,:);
T=eye(4);
for k=1:size(AA,3)
T=T*AA(:,:,k);
Pk=T*P;
set(H(k), 'Vertices',Pk(1:3,:)')
end
%plot3(T(1,4),T(2,4),T(3,4),'*r','MarkerSize',1); %Markersize é o tamanho do *    
end
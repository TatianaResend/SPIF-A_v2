function H = DrawFramesColor(AA,P,F,c)

T=eye(4);
H=zeros(size(AA,3),1);
Hp=patch('Vertices',P(1:3,:)','Faces',F,'FaceColor',c(:,1));
for k=1:size(AA,3)
    T=T*AA(:,:,k);
    Pk=T*P;
    H(k)=patch('Vertices',Pk(1:3,:)','Faces',F,'FaceColor',c(:,k+1));
end
end
function AA = Tlinks(DH)
 AA=zeros(4,4,size(DH,1));   %Matriz 4x4
 for d=1:size(DH,1)
    AA(:,:,d)=Tlink(DH(d,1),DH(d,2),DH(d,3),DH(d,4));
 end
end
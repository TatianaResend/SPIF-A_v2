function Org = LinkOrigins(AA)

Org=zeros(3,size(AA,3));
T=eye(4);
    for k=1:size(AA,3)
        T=T*AA(:,:,k);
        Org(:,k+1) = T(1:3,4);
    end
end
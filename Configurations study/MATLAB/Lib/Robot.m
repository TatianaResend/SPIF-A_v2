function [H,h,P] = Robot(DH, sScale, colors)

if nargin<2     %Caso não se meta o valor da escala, a escala é 1 por defeito
    sScale = 10;
end

if nargin<3     %Caso não se meta as cores, as cores são wbgryk por defeito
    colors = 'wymcbmrkwg';
end
c = colors;
[P, F]=seixos3(sScale);

AA = Tlinks(DH);
Org=LinkOrigins(AA);
h = DrawLinks(Org);
H = DrawFramesColor(AA,P,F,c);

end
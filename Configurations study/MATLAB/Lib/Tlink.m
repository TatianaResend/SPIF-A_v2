function A = Tlink(teta,l,d,alfa)
A=rotz(teta)*trans(l,0,d)*rotx(alfa);
end
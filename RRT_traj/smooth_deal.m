function PATH = smooth_deal(PATH)
 
hold on;
x = PATH(:,1)';
y = PATH(:,2)';
z = PATH(:,3)';
%三次样条插值
t1=1:1:size(PATH,1);
t=1:0.5:size(PATH,1);
XX=spline(t1,x,t);
YY=spline(t1,y,t);
ZZ=spline(t1,z,t);
plot3(XX,YY,ZZ,'r-')
 
view(3)
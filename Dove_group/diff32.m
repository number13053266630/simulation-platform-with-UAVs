function [x1,x2] = diff32(h,u,length,l)
%非线性导数观测器
wn=0.5;omega=0.7;
%参数设置
x1=zeros(length,1);x2=zeros(length,1);
x1(1)=u(1);
for i=1:(length-1)
    x1(i+1)=x1(i)+h*x2(i);
    x2(i+1)=x2(i)+h*(-wn^2*(x1(i)-u(i))-2*omega*wn*x2(i));
    wn=l*zd_fun(u(i)-x1(i));
    if wn>5
        wn=5;
    end
    if wn<0.1
        wn=0.1;
    end
    %disp(wn);
end
end

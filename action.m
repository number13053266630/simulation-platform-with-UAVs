function [acc,oula_dd] = action(Ux,Uy,Uz,U2,U3,U4,quadpara,systempara)
%飞行器一步动作
xdd=Ux-systempara.kf*quadpara.vel(1)/quadpara.m;
ydd=Uy-systempara.kf*quadpara.vel(2)/quadpara.m;
zdd=Uz-systempara.g-systempara.kf*quadpara.vel(1)/quadpara.m;
acc=[xdd;ydd;zdd];
thetadd=U2-quadpara.l*systempara.kf*quadpara.attitude_d(1)/quadpara.iy+...
    (quadpara.iz-quadpara.ix)*quadpara.attitude_d(2)*quadpara.attitude_d(3)/quadpara.iy;
phidd=U3-quadpara.l*systempara.kf*quadpara.attitude_d(2)/quadpara.ix+...
    (quadpara.iy-quadpara.iz)*quadpara.attitude_d(1)*quadpara.attitude_d(3)/quadpara.ix;
psidd=U4-quadpara.l*systempara.kf*quadpara.attitude_d(3)/quadpara.iz+...
    (quadpara.ix-quadpara.iy)*quadpara.attitude_d(1)*quadpara.attitude_d(2)/quadpara.iz;
oula_dd=[thetadd;phidd;psidd];
end


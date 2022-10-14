function dat_cylinder = cylinder_coor_deal(dat_xia)
%% 将16个圆柱障碍物直径和高度等参数放在元胞数组里，至于为什么存在元胞数组里面，没有为什么，个人爱好
lin = size(dat_xia,1);
dat_cylinder=cell(lin,1);
for k1=1:lin
    dat_cylinder{k1}=dat_xia(k1,:);
end
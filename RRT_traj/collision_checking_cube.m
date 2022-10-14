function flag = collision_checking_cube(num_cube,dat_cube,coor_new,coor_near,Delta,deta)
%·¢ÉúÅö×²·µ»Ø1
flag = 0;
% flag1 = 0;
% flag2 = 0;
% flag2_mid1 = 0;
% flag2_mid2 = 0;
% flag2_mid3 = 0;
for k1=1:num_cube
    x_min = min(dat_cube{k1}(:,1));
    x_max = max(dat_cube{k1}(:,1));
    y_min = min(dat_cube{k1}(:,2));
    y_max = max(dat_cube{k1}(:,2));
    z_min = min(dat_cube{k1}(:,3));
    z_max = max(dat_cube{k1}(:,3));
    
    for r=0:Delta/deta:Delta
        coor_mid = rrt_steer(coor_new,coor_near,r);
        if ((x_min<coor_mid(1))&&(coor_mid(1)<x_max))&&((y_min<coor_mid(2))&&(coor_mid(2)<y_max))&&((z_min<coor_mid(3))&&(coor_mid(3)<z_max))
             flag = 1;
             break;
        end
    end
end
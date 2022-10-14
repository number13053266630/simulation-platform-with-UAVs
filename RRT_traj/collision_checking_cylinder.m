function flag = collision_checking_cylinder(num_cylinder,dat_cylinder,coor_new,coor_near,Delta,deta)
%·¢ÉúÅö×²·µ»Ø1
flag = 0;
 
for k1=1:num_cylinder
    x_coor = dat_cylinder{k1}(1);
    y_coor = dat_cylinder{k1}(2);
    z_coor = dat_cylinder{k1}(3);
    R = dat_cylinder{k1}(4)/2;
    height = dat_cylinder{k1}(5);
     
    for r=Delta/deta:Delta
        coor_mid = rrt_steer(coor_new,coor_near,r);
        if (((x_coor-coor_mid(1))^2+(y_coor-coor_mid(2))^2-R^2) < 0) && (z_coor<coor_mid(3)) && (coor_mid(3)<z_coor+height)
             flag = 1;
             break;
        end
    end
end
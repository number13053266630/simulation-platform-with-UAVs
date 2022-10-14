function [coor_near,coor_index] = rrt_near(coor_rand,T)
 
min_distance = calculate_distance3(coor_rand,[T.x(1),T.y(1),T.z(1)]);
 
for T_iter=1:size(T.x,2)
    temp_distance=calculate_distance3(coor_rand,[T.x(T_iter),T.y(T_iter),T.z(T_iter)]);
    
    if temp_distance<=min_distance
        min_distance=temp_distance;
        coor_near(1)=T.x(T_iter);
        coor_near(2)=T.y(T_iter);
        coor_near(3)=T.z(T_iter);
        coor_index=T_iter;
    end
end
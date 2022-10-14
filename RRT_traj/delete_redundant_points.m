function path_best = delete_redundant_points(path,num_cylinder,dat_cylinder,num_cube,dat_cube)
num_points = size(path,1);
count = 1;
start_point = path(1,:);
index = zeros(1,num_points);
for k1 = 1:num_points-2
    count = count+1;
    final_point = path(count+1,:);
    if  (collision_checking_cylinder(num_cylinder,dat_cylinder,final_point,start_point,calculate_distance3(final_point,start_point),3)||...
           collision_checking_cube(num_cube,dat_cube,final_point,start_point,calculate_distance3(final_point,start_point),3))
       start_point = path(count,:);
    else
        index(count) = count;
    end
end
index(index==0) = [];
path([index(end:-1:1)],:) = [];
path_best = path;
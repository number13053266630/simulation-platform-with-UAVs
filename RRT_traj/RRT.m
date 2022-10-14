function [path_best,smooth_path] = RRT(num_cube,dat_cube,num_cylinder,dat_cylinder,start,goal)
%% 流程初始化
 
Delta=0.5;                % 设置扩展步长，扩展结点允许的最大距离，这个数据越大迭代越快，但是比最优解效果越差
max_iter = 10000;        % 最大迭代次数，如果超过这个次数还没找到路径则认为找不到路径
Map = [goal(1)-start(1),goal(2)-start(2),goal(3)-start(3)];
count = 1;
 
%% 构建初始化树
T.x(1) = start(1);
T.y(1) = start(2);
T.z(1) = start(3);
T.xpar(1) = goal(1);
T.ypar(1) = goal(2);
T.zpar(1) = goal(3);
T.dist(1) = 0;
T.indpre(1) = 0;
 
tic
for iter = 1:max_iter
 
    % step1: 在地图上随机采样
    coor_rand = rrt_sample(Map,goal,start);     %在空间进行随机采样，coor_rand是一个  1×3  的数组
    % plot3(coor_rand(1),coor_rand(2),coor_rand(3),'r*')
    
    % step2 : 遍历树，找到最近的父节点
    [coor_near,coor_index] = rrt_near(coor_rand,T);
    
    % step3: 扩展得到新的节点
    coor_new = rrt_steer(coor_rand,coor_near,Delta);
    
    % step4: 碰撞检测,发生碰撞就会返回1
    flag1 = collision_checking_cube(num_cube,dat_cube,coor_new,coor_near,Delta,3);%这部分是检测是否和长方体障碍物碰撞的函数
    flag2 = collision_checking_cylinder(num_cylinder,dat_cylinder,coor_new,coor_near,Delta,3);%这部分是检测是否和圆柱体障碍物碰撞的参数
 
    if flag1 || flag2
        continue;
    end
 
    count = count+1;
    % step5:将新点插入进去
    T.x(count) = coor_new(1);
    T.y(count) = coor_new(2);
    T.z(count) = coor_new(3);
    T.xpar(count) = coor_near(1);
    T.ypar(count) = coor_near(2);
    T.zpar(count) = coor_near(3);
    T.dist(count) = calculate_distance3(coor_new,coor_near);
    T.indpre(count) = coor_index;
    line([coor_near(1),coor_new(1)],[coor_near(2),coor_new(2)],[coor_near(3),coor_new(3)],'LineWidth',1);
    pause(0.1); %暂停0.1s，使得RRT扩展过程容易观察；
    % 注意：  pause函数时暂停函数，如果为了显示动画则这部分十分重要，不过不加上则会静止动画，不能展示动图
 
    % step6:每次迭代出新点后都检查一遍是否可以直接和终点相连
    if    ~(collision_checking_cylinder(num_cylinder,dat_cylinder,goal,coor_new,calculate_distance3(goal,coor_new),20)||...
           collision_checking_cube(num_cube,dat_cube,goal,coor_new,calculate_distance3(goal,coor_new),20))
        count = count+1;
        T.x(count) = goal(1);
        T.y(count) = goal(2);
        T.z(count) = goal(3);
        T.xpar(count) = coor_new(1);
        T.ypar(count) = coor_new(2);
        T.zpar(count) = coor_new(3);
        T.dist(count) = calculate_distance3(coor_new,goal);
        T.indpre(count) = 0;
        line([goal(1),coor_new(1)],[goal(2),coor_new(2)],[goal(3),coor_new(3)],'LineWidth',3,'MarkerSize',2);
        pause(0.1); %暂停0.1s，使得RRT扩展过程容易观察
        break;
    end
 
    
end
 
toc
 
% 算法找到路径点后找到到达终点的父代点集合存储在path变量中
if iter>max_iter
    error('超过最大迭代次数，路径规划失败');
end
path(1,1) = T.x(end);path(1,2) = T.y(end);path(1,3) = T.z(end);
path(2,1) = T.x(end-1);path(2,2) = T.y(end-1);path(2,3) = T.z(end-1);
count2 = 2;
ind_pre = T.indpre(end-1);
if iter<=max_iter
    while ~(ind_pre==0)
        count2 = count2+1;
        path(count2,1) = T.x(ind_pre);
        path(count2,2) = T.y(ind_pre);
        path(count2,3) = T.z(ind_pre);
        ind_pre = T.indpre(ind_pre);
    end
 
end
% line(path(:,1),path(:,2),path(:,3),'LineWidth',1,'Color','r');
 
        
%% RRT算法找到新点全部集合，接下来要去除冗余点
path_best = delete_redundant_points(path,num_cylinder,dat_cylinder,num_cube,dat_cube);
smooth_path = smooth_deal(path);
line(path_best(:,1),path_best(:,2),path_best(:,3),'LineWidth',3,'Color','r');
 
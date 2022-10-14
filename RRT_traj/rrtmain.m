%% 清空变量
clear
clc
%% 导入数据
[dat_chicun,dat_jiaodian,dat_xia] = xlsData();
 
%% 画图
color_mat=rand(size(dat_jiaodian,1),3);   %生成随机矩阵作为颜色用
hold on   %画在同一个图像上
grid on   % 画网格
for k1=1:size(dat_jiaodian,1)
    plotcube(dat_chicun(k1,[2,1,3]),dat_jiaodian(k1,1:3),0.6,color_mat(k1,:))%这个是画长方体障碍物的函数
end
 
for k2=1:size(dat_xia,1)
    plot_cylinder(dat_xia(k2,1:3),dat_xia(k2,4),dat_xia(k2,5),1,rand(1,3));%这个是画圆柱体障碍物的函数
end
axis([0 200 0 200 -20 60 ])   %设置图像的可视化范围
axis equal     % 图像坐标轴可视化间隔相等  
xlabel('x');   
ylabel('y')
 
 
%% 数据重处理
num_cube = size(dat_jiaodian(2:end,:),1);                  %长方体障碍物个数15
[dat_cube,dat_pingban] = cube_coor_deal(dat_jiaodian);     %将长方体角点元素存储在元胞数组，方便索引
num_cylinder = size(dat_xia,1);                            %圆柱体障碍物个数
dat_cylinder = cylinder_coor_deal(dat_xia);                %将圆柱体数据存放在元胞数组里，方便访问
 
% num_cube:     长方体障碍物个数
% dat_cube:     长方体角点的元胞数组
% dat_pingban:  平板角点元胞数组
% num_cylinder: 圆柱体障碍物个数
% dat_cylinder: 圆柱体障碍物数据元胞
 
%% rrt算法部分
GG = [20 100 8;50 110 8];%目标点坐标，有多个目标点就将每个目标点坐标放在这里
PATH = [];
Smooth_path=[];
for k3 = 1:size(GG,1)-1
        start = GG(k3,:);
        goal = GG(k3+1,:);
        [path_best,smooth_path] = RRT(num_cube,dat_cube,num_cylinder,dat_cylinder,start,goal);%每次找到最好路径存放在这个变量里
                                                                        %注意：这个路径点是经过冗余点处理以后的，所以点很少
        line(path_best(:,1),path_best(:,2),path_best(:,3),'LineWidth',2,'Color','b');%将找到路径的点集合用直线画出来
        PATH = [PATH;path_best];
        Smooth_path=[Smooth_path;smooth_path];
end

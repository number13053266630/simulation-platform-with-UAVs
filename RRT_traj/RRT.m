function [path_best,smooth_path] = RRT(num_cube,dat_cube,num_cylinder,dat_cylinder,start,goal)
%% ���̳�ʼ��
 
Delta=0.5;                % ������չ��������չ�������������룬�������Խ�����Խ�죬���Ǳ����Ž�Ч��Խ��
max_iter = 10000;        % ����������������������������û�ҵ�·������Ϊ�Ҳ���·��
Map = [goal(1)-start(1),goal(2)-start(2),goal(3)-start(3)];
count = 1;
 
%% ������ʼ����
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
 
    % step1: �ڵ�ͼ���������
    coor_rand = rrt_sample(Map,goal,start);     %�ڿռ�������������coor_rand��һ��  1��3  ������
    % plot3(coor_rand(1),coor_rand(2),coor_rand(3),'r*')
    
    % step2 : ���������ҵ�����ĸ��ڵ�
    [coor_near,coor_index] = rrt_near(coor_rand,T);
    
    % step3: ��չ�õ��µĽڵ�
    coor_new = rrt_steer(coor_rand,coor_near,Delta);
    
    % step4: ��ײ���,������ײ�ͻ᷵��1
    flag1 = collision_checking_cube(num_cube,dat_cube,coor_new,coor_near,Delta,3);%�ⲿ���Ǽ���Ƿ�ͳ������ϰ�����ײ�ĺ���
    flag2 = collision_checking_cylinder(num_cylinder,dat_cylinder,coor_new,coor_near,Delta,3);%�ⲿ���Ǽ���Ƿ��Բ�����ϰ�����ײ�Ĳ���
 
    if flag1 || flag2
        continue;
    end
 
    count = count+1;
    % step5:���µ�����ȥ
    T.x(count) = coor_new(1);
    T.y(count) = coor_new(2);
    T.z(count) = coor_new(3);
    T.xpar(count) = coor_near(1);
    T.ypar(count) = coor_near(2);
    T.zpar(count) = coor_near(3);
    T.dist(count) = calculate_distance3(coor_new,coor_near);
    T.indpre(count) = coor_index;
    line([coor_near(1),coor_new(1)],[coor_near(2),coor_new(2)],[coor_near(3),coor_new(3)],'LineWidth',1);
    pause(0.1); %��ͣ0.1s��ʹ��RRT��չ�������׹۲죻
    % ע�⣺  pause����ʱ��ͣ���������Ϊ����ʾ�������ⲿ��ʮ����Ҫ��������������ᾲֹ����������չʾ��ͼ
 
    % step6:ÿ�ε������µ�󶼼��һ���Ƿ����ֱ�Ӻ��յ�����
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
        pause(0.1); %��ͣ0.1s��ʹ��RRT��չ�������׹۲�
        break;
    end
 
    
end
 
toc
 
% �㷨�ҵ�·������ҵ������յ�ĸ����㼯�ϴ洢��path������
if iter>max_iter
    error('����������������·���滮ʧ��');
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
 
        
%% RRT�㷨�ҵ��µ�ȫ�����ϣ�������Ҫȥ�������
path_best = delete_redundant_points(path,num_cylinder,dat_cylinder,num_cube,dat_cube);
smooth_path = smooth_deal(path);
line(path_best(:,1),path_best(:,2),path_best(:,3),'LineWidth',3,'Color','r');
 
%% ��ձ���
clear
clc
%% ��������
[dat_chicun,dat_jiaodian,dat_xia] = xlsData();
 
%% ��ͼ
color_mat=rand(size(dat_jiaodian,1),3);   %�������������Ϊ��ɫ��
hold on   %����ͬһ��ͼ����
grid on   % ������
for k1=1:size(dat_jiaodian,1)
    plotcube(dat_chicun(k1,[2,1,3]),dat_jiaodian(k1,1:3),0.6,color_mat(k1,:))%����ǻ��������ϰ���ĺ���
end
 
for k2=1:size(dat_xia,1)
    plot_cylinder(dat_xia(k2,1:3),dat_xia(k2,4),dat_xia(k2,5),1,rand(1,3));%����ǻ�Բ�����ϰ���ĺ���
end
axis([0 200 0 200 -20 60 ])   %����ͼ��Ŀ��ӻ���Χ
axis equal     % ͼ����������ӻ�������  
xlabel('x');   
ylabel('y')
 
 
%% �����ش���
num_cube = size(dat_jiaodian(2:end,:),1);                  %�������ϰ������15
[dat_cube,dat_pingban] = cube_coor_deal(dat_jiaodian);     %��������ǵ�Ԫ�ش洢��Ԫ�����飬��������
num_cylinder = size(dat_xia,1);                            %Բ�����ϰ������
dat_cylinder = cylinder_coor_deal(dat_xia);                %��Բ�������ݴ����Ԫ��������������
 
% num_cube:     �������ϰ������
% dat_cube:     ������ǵ��Ԫ������
% dat_pingban:  ƽ��ǵ�Ԫ������
% num_cylinder: Բ�����ϰ������
% dat_cylinder: Բ�����ϰ�������Ԫ��
 
%% rrt�㷨����
GG = [20 100 8;50 110 8];%Ŀ������꣬�ж��Ŀ���ͽ�ÿ��Ŀ��������������
PATH = [];
Smooth_path=[];
for k3 = 1:size(GG,1)-1
        start = GG(k3,:);
        goal = GG(k3+1,:);
        [path_best,smooth_path] = RRT(num_cube,dat_cube,num_cylinder,dat_cylinder,start,goal);%ÿ���ҵ����·����������������
                                                                        %ע�⣺���·�����Ǿ�������㴦���Ժ�ģ����Ե����
        line(path_best(:,1),path_best(:,2),path_best(:,3),'LineWidth',2,'Color','b');%���ҵ�·���ĵ㼯����ֱ�߻�����
        PATH = [PATH;path_best];
        Smooth_path=[Smooth_path;smooth_path];
end

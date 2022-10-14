clearvars -except len;clc;
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
axis([20 80 0 200 -20 60 ])   %����ͼ��Ŀ��ӻ���Χ
axis equal     % ͼ����������ӻ�������  
xlabel('x');   
ylabel('y');
load('xyHis.mat');load('traj1.mat');load('traj2.mat');
pause(5);
% h1=plot3(traj1(:,1),traj1(:,2),traj1(:,3));
% h2=plot3(traj2(:,1),traj2(:,2),traj2(:,3));
% h3=plot3(xyHis(1,:,1),xyHis(1,:,2),xyHis(1,:,3));
% h4=plot3(xyHis(2,:,1),xyHis(2,:,2),xyHis(2,:,3));
% h5=plot3(xyHis(3,:,1),xyHis(3,:,2),xyHis(3,:,3));
h1=plot3(traj(1,:,1),traj(1,:,2),traj(1,:,3));
h2=plot3(traj(2,:,1),traj(2,:,2),traj(2,:,3));
h3=plot3(traj(3,:,1),traj(3,:,2),traj(3,:,3));
h4=plot3(traj(4,:,1),traj(4,:,2),traj(4,:,3));
h5=plot3(traj(5,:,1),traj(5,:,2),traj(5,:,3));

% hold on;
% for i=1:len
% h1=plot3(traj1(i,1),traj1(i,2),traj1(i,3),'.','MarkerSize',18);
% hold on;
% h2=plot3(traj2(i,1),traj2(i,2),traj2(i,3),'.','MarkerSize',18);
% hold on;
% x=[traj1(i,1);traj2(i,1)];y=[traj1(i,2);traj2(i,2)];z=[traj1(i,3);traj2(i,3)];
% h3=line(x,y,z);
% hold on
% pause(0.01);
% h4=plot3(xyHis(1,i,1),xyHis(1,i,2),xyHis(1,i,3),'.','MarkerSize',18);
% hold on
% h5=plot3(xyHis(2,i,1),xyHis(2,i,2),xyHis(2,i,3),'.','MarkerSize',18);
% hold on
% h6=plot3(xyHis(3,i,1),xyHis(3,i,2),xyHis(3,i,3),'.','MarkerSize',18);
% hold on
% delete(h1);delete(h2);delete(h3);delete(h4);delete(h5);delete(h6);
% end
hold off
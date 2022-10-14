clc;clearvars -except Smooth_path;
%% 鸽群初值
sys.R=1;
sys.ts=0.01;
sys.quad_num=5;
sys.len=2000;
sys.kp=2;
sys.kv=2;
sys.kh=1;
%邻接矩阵，表示领导层级关系
sys.adj=[0 0 0 0 0;
         1 0 0 0 0;
         1 1 0 0 0;
         1 1 1 0 0;
         1 1 1 0 0];
%飞行器初始位置,初始速度
pos0=zeros(sys.quad_num,3);
vel0=zeros(sys.quad_num,3);
dis=zeros(sys.quad_num,sys.quad_num);%飞行器间距离
V=dis;
eV=zeros(sys.quad_num,3*sys.quad_num);
delta_p=zeros(sys.quad_num,3*sys.quad_num);
traj=zeros(sys.quad_num,sys.len,3);
speed=zeros(sys.quad_num,sys.len,3);
%控制信号系数
alpha=zeros(sys.quad_num,3);
beta=zeros(sys.quad_num,3);
gamma=zeros(sys.quad_num,3);

%获得长机轨迹
Smooth_path=Smooth_path(end:-1:1,:);
[path_len,~]=size(Smooth_path);
t=(1:1:path_len);
[t,q_des,v_des] = traj_init(t',Smooth_path);
[path_len,~]=size(t);
sys.len=path_len-100;
% x=5*cos(pi/5*t);xd=pi*sin(pi/5*t);
% y=2*t;
% z=2*t;
x=q_des(:,1);y=q_des(:,2);z=q_des(:,3);
figure;
plot3(x,y,z);
hold on
title('长机轨迹');
%axis([-10,60,-10,110,-5,45]);
pos0(1,:)=Smooth_path(1,:);
pos0(2,:)=pos0(1,:)+[1,0,1];
pos0(3,:)=pos0(1,:)+[0,0,1];
pos0(4,:)=pos0(1,:)+[2,1,4];
pos0(5,:)=pos0(1,:)+[1,4,1];
 for i=1:sys.len
     %计算彼此距离,及其势函数值
     pos0(1,:)=[x(i),y(i),z(i)];
     vel0(1,:)=v_des(i,:);
     for j=1:sys.quad_num
         for k=1:sys.quad_num
             dis(j,k)=norm(pos0(j,:)-pos0(k,:));
             if dis(j,k)==0
                 V(j,k)=0;
             else
                 %V(j,k)=log(dis(j,k)^2)+sys.R^2/dis(j,k)^2;%势函数值
                 V(j,k)=log(dis(j,k)^2/sys.R^2)+3*dis(j,k)^2-3*sys.R^2;
             end
             eV(j,3*k-2:3*k)=vel0(j,:)-vel0(k,:); %vj-vk，行减去列
         end
     end
      for j=1:sys.quad_num
         for k=1:sys.quad_num
             delta_p(j,3*k-2:3*k)=pos0(j,:)-pos0(k,:);
         end
      end
     for j=1:sys.quad_num%x轴向控制分量
         alpha(j,1:2)=-sys.kp*sys.adj(j,:)*V(:,j)*(pos0(j,1:2)-pos0(1,1:2));%按照分量修改
         alpha(j,3)=sys.kh*sys.adj(j,:)*delta_p(:,3*j);
         a=eV(:,3*j-2:3*j);
         %disp(sys.adj(j,:)*a);
         beta(j,:)=sys.kv*sys.adj(j,:)*a;
         gamma(j,:)=vel0(1,:)-vel0(j,:);
     end
     U=alpha+beta+gamma;
     for j=1:sys.quad_num
         vel0(j,:)=vel0(j,:)+U(j,:)*sys.ts;
         pos0(j,:)=pos0(j,:)+vel0(j,:)*sys.ts+U(j,:)*sys.ts^2;
         traj(j,i,:)=pos0(j,:);
         speed(j,i,:)=vel0(j,:);
     end
 end
 figure;
 for i=1:sys.quad_num
     plot3(traj(i,:,1),traj(i,:,2),traj(i,:,3));
     hold on
 end
 hold off
 save('traj');
 save('speed');

function [t,q_des,v_des] = traj_init(t_array,q_array)%dtΪ����ʱ��
dt=0.01;
%��������
% t_array=2*[0,2,4,8,10]';
% q_array=10*[1,1,1.5,1.5,2;
%     1,1,1,1.5,2;
%     1,1.5,1.5,1.5,1.5]';
% v_array=[0,0,5,10,10;
%     0,0,5,10,10;
%     0,5,5,10,10;]';
v_array=0;
%�ж��Ƿ����ٶ�Լ�����������ٶȸ�0Ϊ��Լ�����ٶ�ָ����һ��λ�����У�����ʼ����ֹΪ0
[len,~]=size(t_array);
loop=1+floor((t_array(len)-t_array(1))/dt);
q_des=zeros(loop,3);
v_des=zeros(loop,3);
acc_des=zeros(loop,3);
acc=[];
if v_array==0
    v_array0=zeros(len,3);
    speedlim=5;
    for i=2:(len-1)
        e1=(q_array(i,:)-q_array(i-1,:))/norm(q_array(i,:)-q_array(i-1,:));
        v_array0(i,:)=e1*speedlim;
    end
end
v_array=v_array0;
%���ɶ���ʽ
for i=1:3
    t=t_array;
    q=q_array(1,i);
    v=v_array(1,i);
    v_array2=v_array;
    for k=1:length(t_array)-1
     if(k>1)
        dk1=(q_array(k,i)-q_array(k-1,i))/(t_array(k)-t_array(k-1));
        dk2=(q_array(k+1,i)-q_array(k,i))/(t_array(k+1)-t_array(k));
        if((dk2>=0 && dk1>=0) || (dk2<=0 && dk1<=0))
            v_array2(k)=1.0/2.0*(dk1+dk2);
        else
            v_array2(k)=0;
        end  
     end
    end
    for k=1:len-1
    %������ζ���ʽ��ϵ��
      h(k)=q_array(k+1,i)-q_array(k,i);
      T(k)=t_array(k+1)-t_array(k);
      a0(k)=q_array(k,i);
      a1(k)=v_array2(k);
      a2(k)=(3*h(k)-(2*v_array2(k)+v_array2(k+1))*T(k))/(T(k)*T(k));
      a3(k)=(-2*h(k)+(v_array2(k)+v_array2(k+1))*T(k))/(T(k)*T(k)*T(k));
    
    %���ɸ��ι켣�ܻ������ݵ�
    %�ֲ�ʱ������
      tau=t_array(k):dt:t_array(k+1);
    %ȫ��ʱ�����꣬�ɾֲ�ʱ���������
      t=[t;tau(2:end)'];
    %�ֲ�λ������
      qk=a0(k)+a1(k)*power(tau-t_array(k),1)+a2(k)*power(tau-t_array(k),2)+a3(k)*power(tau-t_array(k),3);
    %ȫ��λ������
      q=[q;qk(2:end)'];
    %�ٶ�
      vk=a1(k)+2*a2(k)*power(tau-t_array(k),1)+3*a3(k)*power(tau-t_array(k),2);
      v=[v;vk(2:end)'];
    %���ٶ�
      acck=2*a2(k)+6*a3(k)*power(tau-t_array(k),1);
     if(k==1)
        acc=2*a2(k);
     end
      acc=[acc;acck(2:end)'];
    end
    q_des(:,i)=q(1:loop);v_des(:,i)=v(1:loop);acc_des(:,i)=acc(1:loop);
end 
end


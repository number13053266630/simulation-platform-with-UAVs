
% 沿曲线线运动的多个图形动画
figure;
for i=1:sys.quad_num
    plot3(traj(i,:,1),traj(i,:,2),traj(i,:,3),'LineWidth',0.2);
    hold on
end
axis([10 60 80 130 6 10])
axis equal,axis manual,axis off
ax = gca;
hold on
% 圆轨迹上的运动点
p1 = plot3(traj(1,1,1),traj(1,1,2),traj(1,1,3),'ro','MarkerFaceColor','r','MarkerSize',4);
p2 = plot3(traj(2,1,1),traj(2,1,2),traj(2,1,3),'ro','MarkerFaceColor','b','MarkerSize',2);
p3 = plot3(traj(3,1,1),traj(3,1,2),traj(3,1,3),'ro','MarkerFaceColor','b','MarkerSize',2);
p4 = plot3(traj(4,1,1),traj(4,1,2),traj(4,1,3),'ro','MarkerFaceColor','b','MarkerSize',2);
p5 = plot3(traj(5,1,1),traj(5,1,2),traj(5,1,3),'ro','MarkerFaceColor','b','MarkerSize',2);
% 椭圆轨迹上的运动点
hold off
% 绘制多体运动动画
for i = 1:length(t)
    p1.XData = traj(1,i,1);p1.YData = traj(1,i,2);p1.ZData = traj(1,i,3);
    p2.XData = traj(2,i,1);p2.YData = traj(2,i,2);p2.ZData = traj(2,i,3);
    p3.XData = traj(3,i,1);p3.YData = traj(3,i,2);p3.ZData = traj(3, i,3);
    p4.XData = traj(4,i,1);p4.YData = traj(4,i,2);p4.ZData = traj(4,i,3);
    p5.XData = traj(5,i,1);p5.YData = traj(5,i,2);p5.ZData = traj(5,i,3);
    drawnow
end
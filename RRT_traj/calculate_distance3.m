function dist = calculate_distance3(mat_start,mat_goal)
%% �˺����Ǽ�����ά��ľ����
dist = sqrt((mat_start(1)-mat_goal(1))^2+(mat_start(2)-mat_goal(2))^2+(mat_start(3)-mat_goal(3))^2);
end
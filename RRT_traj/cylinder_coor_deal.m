function dat_cylinder = cylinder_coor_deal(dat_xia)
%% ��16��Բ���ϰ���ֱ���͸߶ȵȲ�������Ԫ�����������Ϊʲô����Ԫ���������棬û��Ϊʲô�����˰���
lin = size(dat_xia,1);
dat_cylinder=cell(lin,1);
for k1=1:lin
    dat_cylinder{k1}=dat_xia(k1,:);
end
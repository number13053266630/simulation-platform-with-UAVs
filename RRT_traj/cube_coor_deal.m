function [dat_cube,dat_pingban] = cube_coor_deal(dat_jiaodian)
%% 将15个障碍物角点存放在15个元胞数组里面
mid1 = dat_jiaodian(1:end,:);
lin = size(mid1,1);
col = size(mid1,2);
mid3 = zeros(col/3,3);
dat_cube_mid = cell(lin,1);
 
for k1=1:lin
    for k2=1:col/3
        mid2 = mid1(k1,3*(k2-1)+1:3*(k2-1)+3);
        mid3(k2,:) = mid2;
    end
    dat_cube_mid{k1}(:,:) = mid3;
end
dat_cube = dat_cube_mid;
dat_cube(1,:)=[];
dat_pingban{1} = dat_cube_mid{1};
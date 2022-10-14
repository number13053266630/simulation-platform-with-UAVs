function coor_rand = rrt_sample(Map,goal,start)
 
rat = 1.5;
if unifrnd(0,1)<0.5
   coor_rand(1)= unifrnd(-0.2,rat)* Map(1);   
   coor_rand(2)= unifrnd(-0.2,rat)* Map(2);   
   coor_rand(3)= unifrnd(-0.2,rat)* Map(3);   
   coor_rand = coor_rand+start;
else
   coor_rand=goal;
end
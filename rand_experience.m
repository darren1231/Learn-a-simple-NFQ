function  experience  = rand_experience()

map_matrix = [1,1,1,1,1,1;
              1,0,0,0,0,1;
              1,0,0,0,0,1;
              1,0,0,0,0,1;
              1,0,0,0,0,1;
              1,1,1,1,1,1];
qtable = zeros(6,6,4);
%Q(state,x1)=  oldQ + alpha * (R(state,x1)+ (gamma * MaxQ(x1)) - oldQ);

a=0.5;
round = 0;

all_count =0;
  while round<10
     
  
round=round+1;
position_x=2;
position_y=2;
count=0;



%input('');
while ~(position_x==5 && position_y==5) 
   
all_count =all_count+1; 
count=count+1;
rand_action = floor(mod(rand*10,4))+1; 

%[max_q, max_index] = max([qtable(position_x,position_y,1) qtable(position_x,position_y,2) qtable(position_x,position_y,3) qtable(position_x,position_y,4)]);

pre_position_x=position_x;
pre_position_y=position_y;

switch rand_action
     
    case 1
        position_y = pre_position_y-1;   %up
    case 2
        position_y = pre_position_y+1;  %down
    case 3
        position_x = pre_position_x-1;  %left
    case 4
        position_x = pre_position_x+1;  %right
    
end
     if(~(pre_position_x==5 && pre_position_y==2 && rand_action==4))
     experience(:,all_count) = [pre_position_x;pre_position_y;position_x;position_y;rand_action];
     else
     all_count=all_count-1;
     end

    if(position_x==1 || position_x==6 || position_y==1 || position_y==6)
        position_x = pre_position_x;
        position_y = pre_position_y;
        reward=-1;
        b=0;
        %disp('wall');
    end
    
    if(position_x==5 && position_y==5)
        reward=1;
        b=0;
    end
   
   
end

disp(['round:' num2str(round) ' collect ' num2str(count) ' experience']);
    
  end
 
disp('end');
  
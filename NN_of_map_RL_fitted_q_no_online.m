%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------------------------------------------------------------------------------
% Project <Neural fitted q iteration>
% Date    : 2015/10/26
% Author  : Kun da Lin
% Comments: Language: Matlab. 
% Source: matlab 
% ---------------------------------------------------------------------------------
% map_matrix = [start,1,1,1,1,1;
%               1,0,0,0,0,1;
%               1,0,0,0,0,1;
%               1,0,0,0,0,1;
%               1,0,0,0,0,1;
%               1,1,1,1,1,goal];
%Q(state,x1)=  oldQ + alpha * (R(state,x1)+ (gamma * MaxQ(x1)) - oldQ);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

action=1;            %initial action
a=0.3;               %learning parameter
round = 0;           %initial round
old_total_q=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   step1:collect random experience
number_experience=rand_experience;
[net_input,net_output] = transport_experience(number_experience);

net = train_rprop(net_input,net_output);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   step2:use random experience to do iteration
for k=1:10
[net,q]=transport_experience_iteration(net,number_experience);
disp(['Do iteration:' num2str(k)]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  visual q_table 
figure(1);
plot_action(net);                       
text = ['test_replay_r',num2str(1)];
print('-f1', '-djpeg', '-r300',text);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  while round<30
      
round=round+1;
position_x=2;       %initial position                                    
position_y=2;
count=0;            %initial count---one round has many counts
experience_count=0;
%input('');
while ~(position_x==5 && position_y==5)     %   set goal station
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
                                            %   if it isn't best policy
                                            %   collect new experience 
                                            %   and do iteration again
        if(experience_count>50)          
        number_experience = [number_experience new_experience];
        for k=1:1
        [net,new_total_q]=transport_experience_iteration(net,number_experience);
        disp(['Collect another 50 experiences,do iteration: ' num2str(k)]);
        disp(['Delta Q: ' num2str(abs(new_total_q-old_total_q))]);
        old_total_q=new_total_q;
        end             
        figure(1);
        plot_action(net);
        text = ['after_new_experience',num2str(count)];
        print('-f1', '-djpeg', '-r300',text);
        experience_count=0;
        clear new_experience;
    end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
experience_count=experience_count+1;
count=count+1;
rand_action = floor(mod(rand*10,4))+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   step3:according to qtable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   stored in the net pick the
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   best policy
for i=1:4
input(:,i)=transport_feature_byte_diff(position_x,position_y,i);
nn_out(i)=sim(net,input(:,i));
end

[min_q, min_index] = min(nn_out);

%rand_number=rand;              %eplison greedy
% if(rand_number>=0.7)
%     action = rand_action;
% else
%     action = min_index;
% end

action=min_index;

pre_position_x=position_x;
pre_position_y=position_y;

switch action                           % step4:implement the policy
     
    case 1
        position_y = pre_position_y-1;  %up
    case 2
        position_y = pre_position_y+1;  %down
    case 3
        position_x = pre_position_x-1;  %left
    case 4
        position_x = pre_position_x+1;  %right
    
end
%collect new_experience
new_experience(:,experience_count) = [pre_position_x;pre_position_y;position_x;position_y;rand_action];

    if(position_x==1 || position_x==6 || position_y==1 || position_y==6)
        position_x = pre_position_x;
        position_y = pre_position_y;
    end
        
% disp('');
% disp('round');
% disp(round);
% 
% disp('position_x');disp(position_x); 
% disp('position_y');disp(position_y);
    
end

disp(['round: ' num2str(round) ' takes ' num2str(count) ' steps']);
% disp(round);
% disp(count);

% for k=1:10
% net=transport_experience_iteration(net,new_experience);
% disp(k);
% end

  end
% save('L21.dat' ,'net.LW{2,1}');
disp('end');
  
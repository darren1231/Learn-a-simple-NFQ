function  [new_net,new_total_q] = transport_experience_iteration(old_net,number_experience)
% number_experience=rand_experience();
% [old_input,old_output] = transport_experience(number_experience);
% old_net = train_rprop(old_input,old_output);
 [min_matrix,total_q]=compute_min(old_net);

[size_x,size_y] = size(number_experience);

for i = 1:size_y
state_x = number_experience(1,i);
state_y = number_experience(2,i);
next_state_x= number_experience(3,i);
next_state_y= number_experience(4,i);
action = number_experience(5,i);

    if(next_state_x==1 || next_state_x==6 || next_state_y==1 || next_state_y==6)
         cost=1;
        
    elseif(next_state_x==5 && next_state_y==5)
        cost=0;
      
    else
        cost=0.01+0.9*min_matrix(next_state_x,next_state_y);
    end
     
input(:,i)=transport_feature_byte_diff(state_x,state_y,action);
output(:,i)=[cost];
end
new_net=train_rprop(input,output);
plot_action(new_net);

[min_matrix,new_total_q]=compute_min(new_net);

end


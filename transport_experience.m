function  [input,output] = transport_experience(number_experience)

%number_experience=rand_experience();
[size_x,size_y] = size(number_experience);

for i = 1:size_y
state_x = number_experience(1,i);
state_y = number_experience(2,i);
next_state_x= number_experience(3,i);
next_state_y= number_experience(4,i);
action = number_experience(5,i);

    if(next_state_x==1 || next_state_x==6 || next_state_y==1 || next_state_y==6)
         cost=0;
        
    elseif(next_state_x==5 && next_state_y==5)
        cost=1;
      
    else
        cost=0;
    end
     
input(:,i)=transport_feature_byte_diff(state_x,state_y,action);
output(:,i)=[cost];
end
end


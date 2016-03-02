function [ min_matrix,total_q] = compute_min(net)
% [input,output] =transport_experience(rand_experience);
% net = train_rprop(input,output);
total_q=0;
for x=2:5
 for y=2:5
        for k=1:4
        find_min(k)=sim(net,transport_feature_byte_diff(x,y,k));
        end
        total_q = total_q + sum(find_min);
    [min_number, min_index] = min(find_min);

    min_matrix(x,y)=min_number;
  end
end
five=0;
      for k=1:4
      five=five+sim(net,transport_feature_byte_diff(5,5,k));
      end
      total_q = total_q-five;
     % disp(total_q);
     min_matrix(5,5)=0;
%     min_matrix(4,5)=1;
%     min_matrix(5,4)=1;
end


function train_rprop_net = train_rprop(input,output)

 %[input,output]=transport_experience(rand_experience);
 %net = feedforwardnet(6,'trainrp');
 net = newff(minmax(input),[12,6,1],{'logsig','logsig','logsig'},'trainrp');

 net.trainParam.showWindow = false;
 net.trainParam.showCommandLine = false;
%  net.layers{1}.transferFcn = 'logsig';
%  net.layers{2}.transferFcn = 'logsig';
 %net.layers{3}.transferFcn = 'logsig';
 net = train(net,input,output);
 train_rprop_net=net;
 
 
 %sim(net,transport_feature_byte_diff(2,2,1));
 
end


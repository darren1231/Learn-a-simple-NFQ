function  output  = transport_feature_byte_diff( x,y,action)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%output=zeros(8,1);

x=5-x;
y=5-y;

a=dec2bin(x,4);
b=dec2bin(y,4);
output=[str2num(a(:));str2num(b(:));0;0;0;0];


output(8+action)=1;

end


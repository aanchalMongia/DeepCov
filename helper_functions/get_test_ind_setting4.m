function [test_ind,len] = get_test_ind_setting4( cv_setting,i,n, Y,Sd,Sv)
%GET_TEST_IND Summary of this function goes here
%   Detailed explanation goes here

% global Sd, Sv

rng(0);
num_drugs=size(Sd,1); num_virus=size(Sv,1);

if(cv_setting==4)
            len=num_virus;
%            test_ind = zeros(num_drugs,length(left_out_virus));
            test_ind = zeros(num_drugs,1);
            curr_used_virus = i;
            
            test_ind(:,1) = (1:num_drugs)' + ((curr_used_virus-1)*num_drugs);
      
            test_ind = reshape(test_ind,numel(test_ind),1);
end
       
function [ auc,aupr,XcROC,YcROC,XcPR,YcPR, T ,y3] = get_CV_results_setting4_inc(Y,n,cv_setting,predictionMethod  )

vi_names = ['Influenza A virus','Influenza B virus','SARS-CoV','SARS-CoV-2','Ebola virus','MERS-CoV','Zika virus'];
lst = [16 17 22 23 3 19 24];
global Sd Sv
% https://in.mathworks.com/matlabcentral/answers/31156-how-do-i-create-a-for-loop-in-matlab
if cv_setting==4
               for j = 4
               i = lst(j);
               i
               [test_ind,len]=get_test_ind_setting4(cv_setting,i,n, Y,Sd,Sv);
%                test_ind
%                size(test_ind)

% https://in.mathworks.com/help/matlab/math/removing-rows-or-columns-from-a-matrix.html#:~:text=The%20easiest%20way%20to%20remove,and%20remove%20the%20second%20row.&text=Now%20remove%20the%20third%20column.               
               
               y2 = Y;
               y2(test_ind) = 0;
               fprintf('*');
               st=tic;
               y3=alg_template(y2,predictionMethod,test_ind ,[]);
%                y3
               
               endt= double(toc-st);
               [AUCs(i),XcROC,YcROC]  = calculate_auc (y3(test_ind),Y(test_ind));    
               [AUPRs(i),XcPR,YcPR, T] = calculate_aupr(y3(test_ind),Y(test_ind));
               
           
               if (length(test_ind)==(round(len/n)-1)) %for 1st fold test_ind has 1 less element than the total elements in test_ind from other 9 folds..so copy 1 ele to X coordinate and Y coordinate
                   disp('Ìn ifffff')
               end
               end
end
        
auc= mean(AUCs);    aupr= mean(AUPRs);
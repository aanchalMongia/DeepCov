function [ topk ] = findtopk(Y,n,cv_setting,predictionMethod,dr)
lst = [16 17 22 23 3 19 24];

for j = 4
i = lst(j);
i
    
    getParameters(predictionMethod,cv_setting);
    [ auc,aupr,XcROC,YcROC,XcPR,YcPR, T ,y3] = get_CV_results_setting4_inc(Y,i,cv_setting,predictionMethod);

%     x = [min(y3,[],1);max(y3,[],1)];
%     b = bsxfun(@minus,y3,x(1,:));
%     y3_norm = bsxfun(@rdivide,b,diff(x,1,1));

    knum=11;
        ypred=y3(:,i);
%         ypred,size(ypred),i
          

        [sortedValues,sortIndex] = sort(ypred,'descend');
%         sortedValues, sortIndex
        ind = sortIndex(1:knum);
        topk = dr(1,ind);
        ind

end

end

   
function [ FinalavgPre,FinalavgRec,FinalavgFpr ] = precision_recall_calc_t(Y,n,cv_setting,predictionMethod,knum)


avgPre=0;
avgRec=0;
avgFpr=0;
p=[];r=[]; f=[];

nou=size(Y,2);
for i=1:nou
% for i=1
    
    getParameters(predictionMethod,cv_setting);
    [ auc,aupr,XcROC,YcROC,XcPR,YcPR, T ,y3] = get_CV_results_setting4(Y,i,cv_setting,predictionMethod);

    x = [min(y3,[],1);max(y3,[],1)];
    b = bsxfun(@minus,y3,x(1,:));
    y3_norm = bsxfun(@rdivide,b,diff(x,1,1));

    %knum=10;
        ypred=y3_norm(:,i);
%         ypred,size(ypred),i

        [sortedVlues,sortIndex] = sort(ypred,'descend');
        ind = sortIndex(1:knum);
%         sortedValues,sortIndex,ind 
         

        for j=1:size(Y,1)
            ypred(j,1) = 0;
        end
        ypred(ind) = 1;
          
        [c,cm,ind,per] = confusion((Y(:,i))',((ypred))'); 
%         i,cm
        

        recall =  cm(2,2) / (sum(cm(2,:)));
%         recall
        precision =  cm(2,2) / sum(cm(:,2));
        
        precision(isnan(precision))=0;
        recall(isnan(recall))=0;
        
        fpr=per(2,2);

        avgPre=avgPre+ precision;
        avgRec=avgRec+ recall;
        avgFpr=avgFpr+fpr;
      
end
knum
FinalavgPre=avgPre/nou; p=[p,avgPre];
FinalavgRec=avgRec/nou; r=[r,avgRec];
FinalavgFpr=avgFpr/nou;  f=[f,avgFpr];

end

   
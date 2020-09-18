clear all
predictionMethod = 'grdmf_2layer'%'gr1bmc_ppxa'%'mc 'dmf'%'mf' %'grmc_admm' %'grmf' 
% % read virus-drug assocaitions

% MATRICES WITHOUT SARS COV 2
load('data_processed/virus_drug_association_first.mat')
mat=mat'; %size of data matrix: #drugsx#vir

global Sd Sv
load('data_processed/first_drug_sim_matrix.mat')
load('data_processed/vir_sim_matrix_first.mat')
load('data_processed/drugs_moa_sim.mat')
load('data_processed/virus_symptoms_sim_second_cos.mat')
Y=mat; 
Sd = Sd1+ Sd2 ;
Sv = Sv1 + Sv2;

%----add dependencies to path----
addpath(genpath('helper_functions'));

%----define parameters----
% n = 10;% 'n' in "n-fold experiment"
n = 10;% 'n' in "n-fold experiment"
global f_roc f_pr

tic
for cv_setting=[1] 
  
getParameters(predictionMethod,cv_setting)
[auc,aupr,XcROC,YcROC,XcPR,YcPR, T ]=get_CV_results(Y,n,cv_setting,predictionMethod  );
   
auc
aupr

end
toc
clear all
predictionMethod = 'grdmf_3layer'%'dlfm_prox_2layer_new';%'gr1bmc_ppxa'%'mc 'dmf'%'mf' %'grmc_admm' %'grmf'
%global dr;
% % read virus-drug assocaitions

% % MATRICES WITH SARS COV 2
%  load('data_processed/virus_drug_association_sarscov2inc.mat')
%  mat=mat'; %size of data matrix: #drugsx#vir
%  % % % 
%   global Sd Sv
%  load('data_processed/first_drug_sim_matrix.mat')
%  load('data_processed/virus_sim_first_inc.mat')
%  load('data_processed/drugs_moa_sim.mat')
%  load('data_processed/virus_symptoms_sim_cos_inc.mat')
% 

% % MATRICES WITHOUT SARS COV 2
 load('data_processed/virus_drug_association_first.mat')
 mat=mat'; %size of data matrix: #drugsx#vir
 global Sd Sv
 load('data_processed/first_drug_sim_matrix.mat')
 load('data_processed/vir_sim_matrix_first.mat')
 load('data_processed/drugs_moa_sim.mat')
 load('data_processed/virus_symptoms_sim_second_cos.mat')

Sd = Sd1 + Sd2;
Sv = Sv1 + Sv2;

Y=mat;  
size(mat);
[a,b] = size(Y(1,:));

%----add dependencies to path----
addpath(genpath('helper_functions'));

%----define parameters----
n = 10;% 'n' in "n-fold experiment"

global f_roc f_pr;

tic


for cv_setting= 4

knum=3;
% % RUN FOR PRECISION, RECALL( USE MATRICES WITHOUT SARS COV 2)
[FinalavgPre,FinalavgRec,FinalavgFpr] = precision_recall_calc_t(Y,n,cv_setting,predictionMethod,knum);
FinalavgPre
FinalavgRec


% % RUN FOR TOP 10 DRUG RECOMMENDATIONS (USE MATRICES WITH SARS COV 2)
% st = findtopk(Y,n,cv_setting,predictionMethod, dr);
 %st'
end

toc
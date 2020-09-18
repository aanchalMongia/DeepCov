function getParameters(classifier,cv_setting)
%
% This function retrieves optimal parameter values based on the supplied
% algorithm, the CV scenario used and the dataset on which prediction will
% be performed.
%
% INPUT:
%  classifier:  algorithm to be used
%  cv_setting:          
%
% OUTPUT:
%  params:   optimal parameter values for given inputs


global k alpha  k1 k2 k3 k4 pp lamda mu1 mu2 mu sigma   
global num_iter p lambda_l lambda_d lambda_t 
global vartheta
    
    switch classifier
      
            case 'grdmf_2layer'
                        switch cv_setting 
                        case 1                            
                          pp=2; alpha=0.05; mu=100; k1=17; k2=15; vartheta=1;
                          case 2
                           
                          pp=2; alpha=0.01; mu=50; k1=20; k2=15; vartheta=10; 
                          case 3
                           pp=5; alpha=0.1; mu=10; k1=17; k2=10; vartheta=2;
                            
                          case 4  %copied cv2 parameters since we hide 10% viruses in cv2                
                            pp=2; alpha=0.01; mu=50; k1=20; k2=15; vartheta=10; % copied cv2 para since viruses are hidden in that cv setting 
                        end
                   
                       
                  case 'grdmf_3layer'
                        switch cv_setting 
                        case 1
                           pp=5; alpha=1; mu=5; k1=23; k2=10;k3=7; vartheta=1;
                          case 2
                           pp=5; alpha=1; mu=0.01; k1=20; k2=15; k3=10; vartheta=1; 
                          case 3
                           pp=5; alpha=1.5; mu=5; k1=23; k2=10; k3=7; vartheta=2;
                            
                          case 4  %copied cv2 parameters since we hide 10% viruses in cv2                
                           pp=5; alpha=1; mu=0.01; k1=20; k2=15; k3=10; vartheta=1; 
                        end
          
      case 'grmf'
          
            num_iter = 2;
            k = 100;
                      switch(cv_setting)
                        
                        case 1
%                            p=7; lambda_l = 0.0313; lambda_d = 0.01;lambda_t = 0.01;
                           p=2; lambda_l = 0.0313; lambda_d = 0.01;lambda_t = 0.05;
                          case 2
                          % old data optimal para:dnt chng to keep corona rsult p=3; lambda_l = 0.125; lambda_d = 0.3;lambda_t = 0.1; 
                           p=2; lambda_l = 0.0625; lambda_d = 0.3;lambda_t = 0.05; %1 extra drug predicted in grmf
                           case 3
                           %p=7 ;lambda_l =0.25; lambda_d =0.25;lambda_t =0.01; 
%                            p=2 ;lambda_l =0.0625; lambda_d =0.05;lambda_t =0.005;
                            p=2 ;lambda_l =0.0625; lambda_d =0.08;lambda_t =0.005;
                        case 4
                           p=2; lambda_l = 0.0625; lambda_d = 0.3;lambda_t = 0.05; %1 extra drug predicted    
                      end
                                   
                                   
        case 'gr1bmc_ppxa'
           
                    switch cv_setting 
                        
                        case 1
                            pp=2;lamda=0.1;mu1=0.24;mu2=0.1;
%                              pp=2;lamda=0.1;mu1=0.05;mu2=0.1;
                        case 2
                            %pp=2;lamda=0.01;mu1=1;mu2=1;
                             % old data optimal para:dnt chng to keep corona rsult pp=2;lamda=0.05;mu1=1;mu2=0.5;
                             pp=2;lamda=0.05;mu1=1;mu2=0.5;
                       case 3
                            %pp=2;lamda=2;mu1=0.1;mu2=1;
                            pp=2;lamda=2;mu1=0.5;mu2=0.5;
                       case 4
                            %pp=2;lamda=0.1;mu1=0.1;mu2=0.1;
                             pp=2;lamda=0.05;mu1=1;mu2=0.5;
                    end

            
        case 'grmc_admm'
                    switch cv_setting 
                        case 1
%                             pp=2;lamda=0.01;mu1=0.01;mu2=0.005;
                             pp=2;lamda=0.01;mu1=0.01;mu2=0.023;
                        case 2
                            %pp=2;lamda=0.01;mu1=0.1;mu2=0.01;
                            % old data optimal para:dnt chng to keep corona rsult pp=2;lamda=0.01;mu1=0.1;mu2=0.001%0.1 for bettr aupr;
                            pp=2;lamda=0.01;mu1=0.05;mu2=0.01;
                        case 3
                            pp=2;lamda=0.01;mu1=1;mu2=0.3;
%                             pp=2;lamda=0.01;mu1=1;mu2=0.1;
                        case 4
                            pp=2;lamda=0.01;mu1=0.05;mu2=0.01;
                    end
    
    end
    
%     pp,mu1,mu2,alpha,k1,k2,k3,k4
            
end

function [X] = dlfm_prox_3layer(y,Sd,St,M,sizeX,rankr, mu )%M_te,full,Xbase,alpha,outsweep)

% Matrix Completion via Doubly Fraph regularized Deep matrix Factorization

% Inputs
% X - matrix to be estimated
% M - masking operator, applied to vectorized form of X
% y - sampled entries

global alpha 
% global outsweep
outsweep = 10;
%initialization

%initialize factors
X_tr=reshape( M(y,2) ,sizeX);
X=X_tr;

[F,S,T]=svd(X);
U1 = F(:,1:rankr(1));% *S(1:rankr(1),1:rankr(1)); temp = mldivide(U1,X); [F,S,T] = lansvd(temp,rankr(2),'L');U2 = F(:,1:rankr(2))*S(1:rankr(2),1:rankr(2));V = mldivide(U2,temp);
V1=S(1:rankr(1),1:rankr(1))*T(:,1:rankr(1))';

[F2,S2,T2]=svd(V1);
U2=F2(:,1:rankr(2));    %U2(U2<0)=0.0001;
V2=S2(1:rankr(2),1:rankr(2))*T2(:,1:rankr(2))';    %V(V<0)=0.0001;

[F3,S3,T3]=svd(V2);
U3=F3(:,1:rankr(3));    %U2(U2<0)=0.0001;
V=S3(1:rankr(3),1:rankr(3))*T3(:,1:rankr(3))';    %V(V<0)=0.0001;

cost1=[]; cost2=[]; cost3=[];

theta=1;
theta_U1=theta;
theta_U2=theta;
theta_U3=theta;
theta_V=theta;

% Laplacian Matrices    
Dd = diag(sum(Sd)); Lr = Dd - Sd;  
if(det(Dd)==0)
    Dd=0.1*eye(size(Dd))+Dd;
end
L_U1 = (Dd^(-0.5))*Lr*(Dd^(-0.5));

Dt = diag(sum(St)); Lc = Dt - St;
if(det(Dt)==0)
    Dt=0.1*eye(size(Dt))+Dt;
end
L_V = (Dt^(-0.5))*Lc*(Dt^(-0.5));

global vartheta

for out = 1:outsweep
out;

        x = X(:);
        x = x + (1/alpha)*M(y - M(x,1),2); %x(x<0)=0;    
        B = reshape(x,sizeX);
        
        X=max(0,(B+(vartheta*U1*U2*U3*V))/(1+vartheta));
               
        U1_k=U1; U2_k=U2; U3_k=U3; V_k=V;
                    
        try
            U1 =sylvester(2*mu*L_U1 + theta_U1*eye(size(L_U1)),  vartheta*(U2*U3*V)*(U2*U3*V)'     ,  X*(U2*U3*V)' + theta_U1*U1_k);          
            
            U2=sylvester( theta_U2*pinv(U1'*U1), vartheta*(U3*V)*(U3*V)'     ,  pinv(U1'*U1)*(theta_U2*U2_k)+vartheta*pinv(U1'*U1)*U1'*X*(U3*V)');
        
            U3=sylvester( vartheta*(U1*U2)'*(U1*U2),theta_U3*pinv(V*V'), vartheta*(U1*U2)'*X*V'*pinv(V*V')+(theta_U3*U3_k)*pinv(V*V') );
         
            V=sylvester( vartheta*(U1*U2*U3)'*U1*U2*U3,   2*mu*L_V+theta_V*eye(size(L_V))  , (U1*U2*U3)'*X+theta_V*V_k);

        catch
           fprintf('!')
        end
        
end


end

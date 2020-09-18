
function [X] = dlfm_prox_2layer(y,Sd,St,M,sizeX,rankr, mu )%M_te,full,Xbase,alpha,outsweep)

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
V=S2(1:rankr(2),1:rankr(2))*T2(:,1:rankr(2))';    %V(V<0)=0.0001;

theta=1;
theta_U1=theta;
theta_U2=theta;
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

global vartheta%=10;
%vartheta=1;%1 2 5 10 20 50 100

for out = 1:outsweep
out;

        x = X(:);
        x = x + (1/alpha)*M(y - M(x,1),2); %x(x<0)=0;    
        B = reshape(x,sizeX);
        
        X=max(0,(B+(vartheta*U1*U2*V))/(1+vartheta));
               
        U1_k=U1; U2_k=U2; V_k=V;
        
         try
            U1 =sylvester(2*mu*L_U1 + theta_U1*eye(size(L_U1)), vartheta*(U2*V)*(U2*V)'     ,  X*(U2*V)' + theta_U1*U1_k);          
            
            U2=sylvester( theta_U2*pinv(U1'*U1), vartheta* V*V'     ,  pinv(U1'*U1)*theta_U2*U2_k+vartheta*pinv(U1'*U1)*U1'*X*V' );            
            
            V=sylvester( vartheta*(U1*U2)'*U1*U2,   2*mu*L_V+theta_V*eye(size(L_V))  , vartheta*(U1*U2)'*X+theta_V*V_k);
           
        catch
               fprintf('!')
         end
 
end


end

function [Yita,P0,GSsmax,Grsmax,N,Po]=functionrsN9_find(N,c,Alpha,G,seed,casers,P0,Yita,key) 
global Keylen
global Ss rs;

if key==1
YitaAll=linspace(0,Yita,Keylen+1);
YitaAll(1)=[];
elseif key==2
YitaAll=linspace(0,Yita,Keylen);
YitaAll=YitaAll+Yita;
elseif key==3||4
YitaAll=linspace(0,2*Yita,Keylen+1);
YitaAll(1)=[]; 
end

for i=1:Keylen/2
P0All((Keylen/2)+1-i)=P0-0.005*(i-1);
end
for i=1:Keylen/2
P0All((Keylen/2)+i)=P0+0.005*(i);
end  

%%%----设定初始变量----------------------end----------%  

for i=1:Keylen
    P0=P0All(i);
    for j=1:Keylen
    Yita=YitaAll(j);
    
%     Pr(i,j)=(P0*one'-Yita*one'*rs')*((Betas-G.*Ss)^-1)*(Alpha-P0*one);
  [keypr,keypo]= maxprofit3(Alpha,P0,Yita,G,rs,Ss);
  Pr(i,j)=keypr;
  Po(i,j)=keypo;
   GSs(i,j)={Ss};
   Grs(i,j)={rs};
    end
end
N=max(max(Pr));
[i,j]=find(Pr==N);
i=i(1);
j=j(1);
P0=P0All(i(1));
Yita=YitaAll(j(1));
GSsmax=GSs{i,j};
Grsmax=Grs{i,j};
Po=Po(i,j);
if i==Keylen||i==1
%     disp(['P0取了边界值',num2str(i)]);
    if i==1
%         disp('重新调整');
    [Yita,P0,GSsmax,Grsmax,N,Po]=functionrsN9_find(N,c,Alpha,G,seed,casers,P0,Yita,3);    
    end
    if i==Keylen
%         disp('重新调整');
    [Yita,P0,GSsmax,Grsmax,N,Po]=functionrsN9_find(N,c,Alpha,G,seed,casers,P0,Yita,4);    
    end
end
if j==Keylen||j==1
%     disp(['Yita取了边界值',num2str(j)]);
    if i==1
%         disp('重新调整');
     [Yita,P0,GSsmax,Grsmax,N,Po]=functionrsN9_find(N,c,Alpha,G,seed,casers,P0,Yita,1);
    end
    if i==Keylen
%         disp('重新调整');
    [Yita,P0,GSsmax,Grsmax,N,Po]=functionrsN9_find(N,c,Alpha,G,seed,casers,P0,Yita,2);
    end
end
%     disp('*调整完成*');
end

function  Result=getlinkIC(Alpha,Beta,G,tmp,rank)

      parfor i=1:rank
          Result(i,:)=linkIC4(Alpha,Beta,G,tmp(i,:));
%           Result(i,:)=linkNC2(Alpha,Beta,G,tmp(i,:));
      end
end
